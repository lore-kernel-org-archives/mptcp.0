Content-Type: multipart/mixed; boundary="===============5941390477647557059=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC] net: mptcp: improve fallback after successful
 3-way-handshake
Date: Tue, 21 Apr 2020 14:57:43 -0700
Message-ID: <alpine.OSX.2.22.394.2004211133370.18697@tedri-mobl.ger.corp.intel.com>
In-Reply-To: 8e5fcbd2e3c6fbf90f6d836fa82de2ceed3298e2.1587490709.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4217

--===============5941390477647557059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 21 Apr 2020, Davide Caratti wrote:

> From: Davide Caratti <dcaratti(a)nst.lab.eng.brq.redhat.com>

I'm guessing this isn't the address you want in the git "Author" field!

>
> a socket can receive data without a DSS option after MP_CAPABLE exchange
> in the three way handshake. In this case, it must fall-back to normal
> TCP in accordance to RFC8684 =C2=A73.7. In addition, fall-back to TCP must
> occur if the peer sends data with a DSS option with zero DLL (so-called
> "infinite mapping"). In case a server needs to fallback and msk->subflow
> is NULL, msk->first can be used for send/receive operations.
>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/protocol.c | 20 +++++++++++++++++++-
> net/mptcp/subflow.c  | 18 ++++++++++++++----
> 2 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 457655ea875b..045aacb68e13 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -736,6 +736,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
> 		pr_debug("fallback passthrough");
> 		ret =3D sock_sendmsg(ssock, msg);
> 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
> +	} else if (__mptcp_needs_tcp_fallback(msk)) {
> +		ssk =3D msk->first;
> +		release_sock((struct sock *)msk);
> +		pr_debug("msk->first passthrough");
> +		ret =3D ssk->sk_prot->sendmsg(ssk, msg, len);
> +		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
> 	}
>
> 	mptcp_clean_una(sk);
> @@ -899,6 +905,14 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
> 			 mptcp_subflow_ctx(ssock->sk));
> 		copied =3D sock_recvmsg(ssock, msg, flags);
> 		return copied;
> +	} else if (__mptcp_needs_tcp_fallback(msk)) {
> +use_mskfirst:
> +		pr_debug("fallback-read using msk->first");
> +		sk =3D msk->first;
> +		release_sock((struct sock *)msk);

sk is one of the function arguments referring to the MPTCP-level socket, =

so a "struct sock *ssk" to use in this block of code would be clearer and =

would remove the cast in the release_sock().

I recognize that in this fallback scenario there is no struct sock =

available, so sock_recvmsg() can't be used, but is there any way to =

handle sendmsg/recvmsg the same after either type of fallback?


> +		copied =3D sk->sk_prot->recvmsg(sk, msg, len, nonblock, flags,
> +					      addr_len);
> +		return copied;
> 	}
>
> 	timeo =3D sock_rcvtimeo(sk, nonblock);
> @@ -963,8 +977,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>
> 		pr_debug("block timeout %ld", timeo);
> 		mptcp_wait_data(sk, &timeo);
> -		if (unlikely(__mptcp_tcp_fallback(msk)))
> +		if (unlikely(__mptcp_tcp_fallback(msk))) {
> +			ssock =3D __mptcp_tcp_fallback(msk);
> +			if (!ssock)
> +				goto use_mskfirst;

This goto doesn't seem reachable - __mptcp_tcp_fallback(msk) should have =

the same return value both times.

> 			goto fallback;
> +		}
> 	}
>
> 	if (skb_queue_empty(&sk->sk_receive_queue)) {
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 47f901b712f9..460288c1c8ff 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -460,7 +460,8 @@ enum mapping_status {
> 	MAPPING_OK,
> 	MAPPING_INVALID,
> 	MAPPING_EMPTY,
> -	MAPPING_DATA_FIN
> +	MAPPING_DATA_FIN,
> +	MAPPING_INFINITE
> };
>
> static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
> @@ -540,8 +541,14 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk)
> 			return MAPPING_EMPTY;
> 		}
>
> -		if (!subflow->map_valid)
> +		if (!subflow->map_valid) {
> +			if (!mpext && !subflow->local_id) {
> +				pr_debug("no mpext and 0 local id");
> +				skb_ext_del(skb, SKB_EXT_MPTCP);

skb_ext_del() wouldn't be required, mptcp_get_ext() already returned NULL =

indicating that mpext isn't there.

> +				return MAPPING_INFINITE;
> +			}

This will treat any skb without a DSS option on the initial subflow as an =

implicit infinite mapping, if there is not a current valid mapping. It's =

possible to encounter this after valid mappings were found and DATA_ACKed.

Section 3.7 is specific about what to do when an ACK (not a data packet) =

without DSS is received on the initial subflow before any other subflows =

are added: this is treated as an implicit infinite mapping, and the next =

data packet that is sent should include an infinite mapping to signal the =

fallback to the peer.

While section 3.7 says a sender "MUST" include a DSS option in every =

segment until a DATA_ACK is received, I don't see a description of what =

happens if the DSS option is missing when the receiver processes it - is =

it supposed to also be treated as a fallback? If so, the code above must =

only return MAPPING_INFINITE if DATA_ACK has never been sent and no other =

subflows have been created.

> 			return MAPPING_INVALID;
> +		}
>
> 		goto validate_seq;
> 	}
> @@ -552,9 +559,8 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk)
>
> 	data_len =3D mpext->data_len;
> 	if (data_len =3D=3D 0) {
> -		pr_err("Infinite mapping not handled");
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> -		return MAPPING_INVALID;
> +		return subflow->local_id ? MAPPING_INVALID : MAPPING_INFINITE;

Like above, I think this requires different logic to determine that there =

are no other subflows and that DATA_ACK has not been sent -- if that's the =

narrow case the code is trying to detect.

The RFC seems to allow infinite mappings on any single subflow connection. =

If a second subflow was established and then the initial subflow (local_id =

=3D=3D 0) was closed, then there could be an infinite mapping on a subflow =

with a different local_id. (If I'm misreading the spec, please let me =

know!). This may be outside the scope of this patch anyway.

> 	}
>
> 	if (mpext->data_fin =3D=3D 1) {
> @@ -663,6 +669,10 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
> 			ssk->sk_err =3D EBADMSG;
> 			goto fatal;
> 		}
> +		if (status =3D=3D MAPPING_INFINITE) {
> +			tcp_sk(ssk)->is_mptcp =3D 0;
> +			return false;
> +		}
>
> 		if (status !=3D MAPPING_OK)
> 			return false;
> -- =

> 2.25.2

--
Mat Martineau
Intel

--===============5941390477647557059==--
