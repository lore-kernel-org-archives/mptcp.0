Content-Type: multipart/mixed; boundary="===============5240759130005228715=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Mon, 02 Oct 2017 16:00:56 -0700
Message-ID: <alpine.OSX.2.21.1710021423010.10266@mjmartin-mac01.sea.intel.com>
In-Reply-To: 20171002211423.GF31629@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 83

--===============5240759130005228715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph -

On Mon, 2 Oct 2017, Christoph Paasch wrote:

> Hello,
>
> just wanted to ring in here.
>
>
> I started working on porting TCP_MD5 to use the TCP extra-option framework
> from Mat's branch.
>
> It allows to nicely cleanup the TCP_MD5-code out of the TCP data-path.
> There are some changes/extensions I needed to do to Mat's framework. But
> nothing. I will post patches in the coming days here on the list.
>

I'm glad the framework is working well for the MD5 cleanup. I had set that =

aside for a while, but one thing I remember wanting to fix was the option =

writing callback. It seemed like a per-socket callback (especially for =

connections in the 'established' state) would be an improvement, so every =

socket doesn't have to tranverse the entire list of callbacks.

>
> I keep on moving mptcp_trunk upwards to track upstream Linux. Currently I=
'm
> stuck at v4.9 (there is a nasty bug that popped up with the merge and I
> wasn't able to fix that yet).
>
>
> The merge with v4.9 also forced me to bump skb->cb to 80 bytes... :/
> I have been thinking back and forth on how we could handle this. The best
> way I see at the moment is to create a scratch-area at the end of the skb=
's
> data (like skb_shared_info). I think it also would quite nicely fit with a
> KCM/ULP-style architecture where we could have a BPF-program that does the
> scheduling.
> I haven't dived very deep into the skb->cb problem yet.
>

I don't think we're the first ones to want more control block bytes, seems =

like finding a solution would help outside of MPTCP too. I've looked at =

skb_tailroom_reserve a little bit, and also given some preliminary thought =

to stashing header info in skb_shared_info->frags (maybe by creating =

"header fragments").

>
> Anyways, at the moment I am focusing on fixing mptcp_trunk's merge with v=
4.9
> and the TCP_MD5 cleanup (which I think would be of interest for netdev).

I really appreciate the update, thank you!


--
Mat Martineau
Intel OTC

--===============5240759130005228715==--
