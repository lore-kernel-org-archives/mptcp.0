Content-Type: multipart/mixed; boundary="===============7351505152601831222=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: fix hooking for mptcp_incoming_options()
Date: Thu, 29 Aug 2019 16:00:05 +0200
Message-ID: <74ae6e8a-7dd0-012a-b900-282c84005914@tessares.net>
In-Reply-To: alpine.OSX.2.21.1908280947490.21729@aaggar2-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1761

--===============7351505152601831222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 28/08/2019 18:55, Mat Martineau wrote:
> On Wed, 28 Aug 2019, Paolo Abeni wrote:
> =

>> Currently we don't process mptcp options for half-open sockets, e.g.
>> for packet with payload delivered to the rx queue via
>> tcp_rcv_state_process(), and for pure ack landing in the same code path.
>>
>> We can deal with the first code path moving the existing
>> mptcp_incoming_options() hook inside tcp_data_queue(), but we need
>> to add an additional hook to deal with the specified pure acks
>>
>> Fixes: d2d58ff48665 ("mptcp: Implement MPTCP receive path")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> I'm ok with squashing this one into the fixed patch
>> Any other option not needing an additional hook more than welcome
>> The reported issue does not affect the existing code base,
>> but as soon as we start tracking the MPTCP level unacked sequence
>> number it become apparent, as we can't track it for
>> half-open sockets
> =

> I think this is the right fix, and tcp_data_queue seems like a good
> place to move the mptcp_incoming_options call.

Thank you for the patch and the review!

> Would be good to squash this as Paolo mentions.

Just did!
- d39bdd4e1249: "squashed" in "mptcp: Implement MPTCP receive path"
- signed-off was already there
- 695f625aa913..a9b6b4ccd61e: result

Cheers,
Matt

>> ---
>> net/ipv4/tcp_input.c | 12 +++++++-----
>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 1c06cfb06374..cf2cf09d7d3d 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4763,6 +4763,9 @@ static void tcp_data_queue(struct sock *sk,
>> struct sk_buff *skb)
>> =C2=A0=C2=A0=C2=A0=C2=A0bool fragstolen;
>> =C2=A0=C2=A0=C2=A0=C2=A0int eaten;
>>
>> +=C2=A0=C2=A0=C2=A0 if (sk_is_mptcp(sk))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_incoming_options(sk, s=
kb, &tp->rx_opt);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)-=
>end_seq) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __kfree_skb(skb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> @@ -5711,10 +5714,6 @@ void tcp_rcv_established(struct sock *sk,
>> struct sk_buff *skb)
>> =C2=A0=C2=A0=C2=A0=C2=A0/* Process urgent data. */
>> =C2=A0=C2=A0=C2=A0=C2=A0tcp_urg(sk, skb, th);
>>
>> -=C2=A0=C2=A0=C2=A0 /* Process MPTCP options */
>> -=C2=A0=C2=A0=C2=A0 if (sk_is_mptcp(sk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_incoming_options(sk, s=
kb, &tp->rx_opt);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0/* step 7: process the segment text */
>> =C2=A0=C2=A0=C2=A0=C2=A0tcp_data_queue(sk, skb);
>>
>> @@ -6335,8 +6334,11 @@ int tcp_rcv_state_process(struct sock *sk,
>> struct sk_buff *skb)
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_CLOSE_WAIT:
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_CLOSING:
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_LAST_ACK:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!before(TCP_SKB_CB(skb)-=
>seq, tp->rcv_nxt))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!before(TCP_SKB_CB(skb)-=
>seq, tp->rcv_nxt)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
sk_is_mptcp(sk))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mptcp_incoming_options(sk, skb, &tp->rx_opt);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fall through */
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_FIN_WAIT1:
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_FIN_WAIT2:
> =

> Some additional context for other reviewers: this fall through path does
> end up calling tcp_data_queue (unless the socket is shut down already),
> so mptcp_incoming_options will get called on that path too.

Thank you for this extra note!

Cheers,
Matt

> -- =

> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7351505152601831222==--
