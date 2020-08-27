Content-Type: multipart/mixed; boundary="===============3281787881547848609=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: cleanup
 mptcp_subflow_discard_data()"
Date: Thu, 27 Aug 2020 11:18:25 +0200
Message-ID: <0a24c20f23fa93f15cc79de251c4c1362c0c4cec.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2008261654250.48113@dandrus-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5642

--===============3281787881547848609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-08-26 at 17:16 -0700, Mat Martineau wrote:
> On Tue, 25 Aug 2020, Paolo Abeni wrote:
> =

> > While discarding old data we also need to flush the
> > related map, if completed/exausted.
> > =

> > Additionally, use a safer condition to check for to-be-eaten
> > skbs
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > with this and pending Florian's patches, the kernel survived
> > the following loop for quite a bit.
> > =

> > while true; do
> > 	./mptcp_connect.sh -d 10 -l 0 -r 0 -e "" -f $((100 * 1024 * 1024)) -m =
poll
> > done
> > =

> > I still see poll timeout with both ends not readable - not
> > investigated yet.
> > ---
> > net/mptcp/subflow.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > =

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 3585fd63c757..34c195ed1371 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -819,8 +819,10 @@ static void mptcp_subflow_discard_data(struct sock=
 *ssk, struct sk_buff *skb,
> > 		 subflow->map_subflow_seq);
> > 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
> > 	tcp_sk(ssk)->copied_seq +=3D incr;
> > -	if (incr >=3D skb->len)
> > +	if (tcp_sk(ssk)->copied_seq >=3D TCP_SKB_CB(skb)->end_seq)
> =

> if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq)) ?

Whoops! you are right! thank you for spotting this. I'll send a v2
after some testing.

Cheers,

Paolo

--===============3281787881547848609==--
