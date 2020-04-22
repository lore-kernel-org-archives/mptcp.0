Content-Type: multipart/mixed; boundary="===============3321413165338427565=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC] net: mptcp: improve fallback after successful
 3-way-handshake
Date: Wed, 22 Apr 2020 13:45:07 +0200
Message-ID: <b136437afd19a1dc31ef21c913dd4d531c971ac0.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2004211133370.18697@tedri-mobl.ger.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4220

--===============3321413165338427565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-04-21 at 14:57 -0700, Mat Martineau wrote:
> On Tue, 21 Apr 2020, Davide Caratti wrote:
> =

> > From: Davide Caratti <dcaratti(a)nst.lab.eng.brq.redhat.com>
> =

> I'm guessing this isn't the address you want in the git "Author" field!
> =

> > a socket can receive data without a DSS option after MP_CAPABLE exchange
> > in the three way handshake. In this case, it must fall-back to normal
> > TCP in accordance to RFC8684 =C2=A73.7. In addition, fall-back to TCP m=
ust
> > occur if the peer sends data with a DSS option with zero DLL (so-called
> > "infinite mapping"). In case a server needs to fallback and msk->subflow
> > is NULL, msk->first can be used for send/receive operations.
> > =

> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > ---
> > net/mptcp/protocol.c | 20 +++++++++++++++++++-
> > net/mptcp/subflow.c  | 18 ++++++++++++++----
> > 2 files changed, 33 insertions(+), 5 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 457655ea875b..045aacb68e13 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -736,6 +736,12 @@ static int mptcp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t len)
> > 		pr_debug("fallback passthrough");
> > 		ret =3D sock_sendmsg(ssock, msg);
> > 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
> > +	} else if (__mptcp_needs_tcp_fallback(msk)) {
> > +		ssk =3D msk->first;
> > +		release_sock((struct sock *)msk);
> > +		pr_debug("msk->first passthrough");
> > +		ret =3D ssk->sk_prot->sendmsg(ssk, msg, len);
> > +		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
> > 	}
> > =

> > 	mptcp_clean_una(sk);
> > @@ -899,6 +905,14 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> > 			 mptcp_subflow_ctx(ssock->sk));
> > 		copied =3D sock_recvmsg(ssock, msg, flags);
> > 		return copied;
> > +	} else if (__mptcp_needs_tcp_fallback(msk)) {
> > +use_mskfirst:
> > +		pr_debug("fallback-read using msk->first");
> > +		sk =3D msk->first;
> > +		release_sock((struct sock *)msk);
> =

> sk is one of the function arguments referring to the MPTCP-level socket, =

> so a "struct sock *ssk" to use in this block of code would be clearer and =

> would remove the cast in the release_sock().
> =

> I recognize that in this fallback scenario there is no struct sock =

> available, so sock_recvmsg() can't be used, but is there any way to =

> handle sendmsg/recvmsg the same after either type of fallback?

I *think* the above 2 conditionals can be replaced with only the second
one, e.g. always use 'ssk->sk_prot->{sendmsg,recvmsg}(ssk, msg, len);' =


> > +				return MAPPING_INFINITE;
> > +			}
> =

> This will treat any skb without a DSS option on the initial subflow as an =

> implicit infinite mapping, if there is not a current valid mapping. It's =

> possible to encounter this after valid mappings were found and DATA_ACKed.
> =

> Section 3.7 is specific about what to do when an ACK (not a data packet) =

> without DSS is received on the initial subflow before any other subflows =

> are added: this is treated as an implicit infinite mapping, and the next =

> data packet that is sent should include an infinite mapping to signal the =

> fallback to the peer.
> =

> While section 3.7 says a sender "MUST" include a DSS option in every =

> segment until a DATA_ACK is received, I don't see a description of what =

> happens if the DSS option is missing when the receiver processes it - is =

> it supposed to also be treated as a fallback? If so, the code above must =

> only return MAPPING_INFINITE if DATA_ACK has never been sent and no other =

                                                          ^^^^
received ?!?
                                                          =

> subflows have been created.

I *think* we can add an additional per subflow flag to track the 'first
data_ack received' event, and check READ_ONCE(msk->pm.subflows) =3D=3D 0 to
verify no additional subflows exits.

> > 			return MAPPING_INVALID;
> > +		}
> > =

> > 		goto validate_seq;
> > 	}
> > @@ -552,9 +559,8 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk)
> > =

> > 	data_len =3D mpext->data_len;
> > 	if (data_len =3D=3D 0) {
> > -		pr_err("Infinite mapping not handled");
> > 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> > -		return MAPPING_INVALID;
> > +		return subflow->local_id ? MAPPING_INVALID : MAPPING_INFINITE;
> =

> Like above, I think this requires different logic to determine that there =

> are no other subflows and that DATA_ACK has not been sent -- if that's th=
e =

> narrow case the code is trying to detect.
> =

> The RFC seems to allow infinite mappings on any single subflow connection=
. =

> If a second subflow was established and then the initial subflow (local_i=
d =

> =3D=3D 0) was closed, then there could be an infinite mapping on a subflo=
w =

> with a different local_id. (If I'm misreading the spec, please let me =

> know!). This may be outside the scope of this patch anyway.

from =

https://datatracker.ietf.org/doc/rfc8684/?include_text=3D1, section 3.7.:

"""
      In the case of such an ACK being received on the first subflow
      (i.e., that started with MP_CAPABLE), before any additional
      subflows are added, the implementation MUST drop out of MPTCP mode
      and fall back to regular TCP.
"""

and:

"""
      In the case of this occurring
      on an additional subflow (i.e., one started with MP_JOIN), the
      host MUST close the subflow with a RST, which SHOULD contain an
      MP_TCPRST option (Section 3.6) with a "Middlebox interference"
      reason code.
"""

I think we should cope only with local_id =3D=3D 0

thanks!

/P

--===============3321413165338427565==--
