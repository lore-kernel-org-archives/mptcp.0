Content-Type: multipart/mixed; boundary="===============2255050348091750799=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Mon, 02 Oct 2017 16:28:32 -0700
Message-ID: <20171002232832.GI31629@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1710021423010.10266@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 84

--===============2255050348091750799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On 02/10/17 - 16:00:56, Mat Martineau wrote:
> On Mon, 2 Oct 2017, Christoph Paasch wrote:
> > just wanted to ring in here.
> > =

> > =

> > I started working on porting TCP_MD5 to use the TCP extra-option framew=
ork
> > from Mat's branch.
> > =

> > It allows to nicely cleanup the TCP_MD5-code out of the TCP data-path.
> > There are some changes/extensions I needed to do to Mat's framework. But
> > nothing. I will post patches in the coming days here on the list.
> > =

> =

> I'm glad the framework is working well for the MD5 cleanup. I had set that
> aside for a while, but one thing I remember wanting to fix was the option
> writing callback. It seemed like a per-socket callback (especially for
> connections in the 'established' state) would be an improvement, so every
> socket doesn't have to tranverse the entire list of callbacks.

+1 on the per-socket callback. I have this on my list of things that would
be good to add.

Basically, I think we should move tcp_option_list to struct tcp_sock.
Dynamically allocated there a pointer to the callbacks and also some
additional memory region.

That way, we have a generic way to store the state needed for the extra TCP
option (md5sig_info in TCP_MD5's case).


I have some more comments, but it will be clearer with the TCP_MD5-code at
hand.


> > I keep on moving mptcp_trunk upwards to track upstream Linux. Currently=
 I'm
> > stuck at v4.9 (there is a nasty bug that popped up with the merge and I
> > wasn't able to fix that yet).
> > =

> > =

> > The merge with v4.9 also forced me to bump skb->cb to 80 bytes... :/
> > I have been thinking back and forth on how we could handle this. The be=
st
> > way I see at the moment is to create a scratch-area at the end of the s=
kb's
> > data (like skb_shared_info). I think it also would quite nicely fit wit=
h a
> > KCM/ULP-style architecture where we could have a BPF-program that does =
the
> > scheduling.
> > I haven't dived very deep into the skb->cb problem yet.
> > =

> =

> I don't think we're the first ones to want more control block bytes, seems
> like finding a solution would help outside of MPTCP too. I've looked at
> skb_tailroom_reserve a little bit, and also given some preliminary thought
> to stashing header info in skb_shared_info->frags (maybe by creating "hea=
der
> fragments").



Yes, I also have to look a bit more at tailroom_reserve.

Can you elaborate a bit more on the "header fragments" ?



At one point, I had a more or less crazy idea of storing it inside the
payload.

Here was my train of thought:

Basically, the big problem with MPTCP (ignoring implementations) is that the
IETF decided to put the DSS-option in the TCP option-space. Thus, this
inherintly links a TCP-option with the payload of the packet (due to the
DSS-mapping).
Such linking is bad, for TSO, LRO/GRO, middleboxes splitting segments,...

It would have been much better if the IETF would have placed the DSS-option
(not the DATA_ACK) in the payload and leave the TCP-options just for truly
signalling options (DATA_ACK, ADD_ADDR, REMOVE_ADDR, MP_PRIO,...).

So, I was thinking that we could fake this and the MPTCP-level would do a
regular tcp_sendmsg on the subsockets with the DSS-mapping as part of the
payload. It would also just pass a flag down to tcp_sendmsg, that indicates
that the payload contains a DSS-mapping. This flag would then be stored in
the relevant skb (just one bit - I think we have that space).

Then, later in tcp_options_write, we just need to check on that flag and
extract the DSS-mapping and write it into the TCP header space (and adjust
skb->data,...).


In principle, I think this would have been very clean IMO.


But it doesn't work, because this DSS-mapping will no be accounted in TCP's
sequence space (aka., snd_nxt,...) but in the end it won't be sent out. So,
that would screw up TCP completly. Basically, skb->len will include the
DSS-mapping in the payload but it won't be sent out as part of the payload
but as part of the TCP option-space.

So, because of this I gave up on this avenue.

If you think this could work in another way or something like that, let me
know :)



Christoph



> =

> > =

> > Anyways, at the moment I am focusing on fixing mptcp_trunk's merge with=
 v4.9
> > and the TCP_MD5 cleanup (which I think would be of interest for netdev).
> =

> I really appreciate the update, thank you!
> =

> =

> --
> Mat Martineau
> Intel OTC

--===============2255050348091750799==--
