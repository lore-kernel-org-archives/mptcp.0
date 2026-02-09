Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58728325726
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627388; cv=none; b=SwYOtXZCVPV98SR9+fyoIBhtSGaWUFJih2Me7bInLx6i4gYUJHF5E9DhQr+zUQIXNXp5hOEmMkrjQueppiM42ek8vCQ1b163ZEYM9br6cdKQWkdaSdchCIvNwP7um3ADrOdmuJ3anEszcRgxFBRaQhMslQXCZdWT4dyEPgCSULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627388; c=relaxed/simple;
	bh=o29VLFWL4OiMJrnfTosZiyVguedtfaB+tVE1wBpQVDc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=aj8piMwwwNSJHDo8MNOE9YunsqZnzkVAwd8s18WMKp+McdrXUDp6rhgKqeWjeyDmS5/Y1qTMi7RQIcZez2vdLcXndbEHIdViGvE3iIl4t8Q3t+2EAXYaOM2/lA23Vi12yrfa7gRXLoaRYQgNh6r+Q/LDFb6EWma3O9PkV92noZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdyL8UaN; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdyL8UaN"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770627385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9/G/jSovElAAhaUlJxgJSTizpiaLnBHzYQyriOxV2o=;
	b=WdyL8UaNMmatajuF2VQnDFiq2jxzH80gKE8JwyGe7ESrrTPpmFiymYQc4hOrZmFwlQ53Vb
	dT063rnuXM7hXSjOu+jIIKv4OEe7ceyPF0b44hfEapQjDhjiWQaPqp8d5f1WQI39Ie9Aar
	2H+zCiQtxD+ChclBuHRJkbp1hjguUms=
Date: Mon, 09 Feb 2026 08:56:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <bbfddacc3932c6380dbf33e848b8890d805f423e@linux.dev>
TLS-Required: No
Subject: Re: [Patch mptcp-net 3/3] mptcp: fix stall because of data_ready
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
In-Reply-To: <ae1e6eed249537f658201bd6692845257a3126db@linux.dev>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <de0a7e3ea6a3cac75b3c2c811695c5d674d929ef.1770273341.git.yangang@kylinos.cn>
 <44a1f815-45bf-49b2-a772-6e0d53fdbbae@redhat.com>
 <ae1e6eed249537f658201bd6692845257a3126db@linux.dev>
X-Migadu-Flow: FLOW_OUT

February 5, 2026 at 9:27 PM, gang.yan@linux.dev mailto:gang.yan@linux.dev=
  wrote:


>=20
>=20February 5, 2026 at 6:07 PM, "Paolo Abeni" <pabeni@redhat.com mailto:=
pabeni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > =
wrote:
> Hi, Paolo:
>=20
>=20>=20
>=20> On 2/5/26 7:41 AM, Gang Yan wrote:
> >=20=20
>=20>=20=20
>=20>  From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  This patch fixes the second type of backlog_list stall issue that
> >  occurs when the data_ready callback attempts to trigger data transfe=
r.
> >  The issue reproduces at approximately a 20% rate (once every five ru=
ns)
> >  when running multi_chunk.sh tests.
> >=20=20
>=20>  The stall occurs under the following conditions:
> >  1. A large amount of out-of-order (OFO) data causes sk_rmem_alloc to
> >  exceed sk_rcvbuf
> >=20=20
>=20>  Thinking again about this scenario, the above condition is quite
> >  unexpected to me. Could you please share a pcap capture of this stal=
l?
> >  In theory the sender should not fill the rcv window with OoO skb onl=
y.
> >=20
>=20The captured packets (ns1.pcap) are attached to this email.
>=20
>=20>=20
>=20> 2. The skb matching the current ack_seq is not present in backlog_l=
ist
> >  3. Data reception relies on data_ready callback notification
> >=20=20
>=20>  In this scenario, the data_ready callback (via mptcp_data_ready() =
->
> >  sk->sk_data_ready()) attempts to trigger data movement, but
> >  __mptcp_move_skbs_from_subflow() repeatedly moves the ack_seq skb in=
to
> >  backlog_list and returns false:
> >=20=20
>=20>  '''
> >  [ 144.961282][ C0] MPTCP: msk->ack_seq:3442119990924456661, map_seq:=
3442119990924456661, offset:0, fin:0
> >  [ 144.961293][ C0] MPTCP: [MPTCP_BACKLOG] #0 map_seq=3D3442119990924=
655746 end_seq=3D3442119990924660542 len=3D4796
> >  [ 144.962310][ C0] MPTCP: [MPTCP_BACKLOG] #1 map_seq=3D3442119990924=
491850 end_seq=3D3442119990924500364 len=3D8514
> >  [ 144.962783][ C0] MPTCP: [MPTCP_BACKLOG] #2 map_seq=3D3442119990924=
660542 end_seq=3D3442119990924726001 len=3D65459
> >  [ 144.963260][ C0] MPTCP: [MPTCP_BACKLOG] #3 map_seq=3D3442119990924=
508114 end_seq=3D3442119990924514971 len=3D6857
> >  [ 144.963729][ C0] MPTCP: [MPTCP_BACKLOG] #4 map_seq=3D3442119990924=
726001 end_seq=3D3442119990924731093 len=3D5092
> >  [ 144.964193][ C0] MPTCP: [MPTCP_BACKLOG] #5 map_seq=3D3442119990924=
456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.964651][ C0] MPTCP: [MPTCP_BACKLOG] #6 map_seq=3D3442119990924=
456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.965164][ C0] MPTCP: [MPTCP_BACKLOG] #7 map_seq=3D3442119990924=
456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.965711][ C0] MPTCP: [MPTCP_BACKLOG] #8 map_seq=3D3442119990924=
456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.966260][ C0] MPTCP: [MPTCP_BACKLOG] #9 map_seq=3D3442119990924=
456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.966804][ C0] MPTCP: [MPTCP_BACKLOG] #10 map_seq=3D344211999092=
4456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.967308][ C0] MPTCP: [MPTCP_BACKLOG] #11 map_seq=3D344211999092=
4456661 end_seq=3D3442119990924464310 len=3D7649
> >  [ 144.967793][ C0] MPTCP: [MPTCP_BACKLOG] #12 map_seq=3D344211999092=
4456661 end_seq=3D3442119990924464310 len=3D7649
> >  ...
> >  '''
> >=20=20
>=20>  The fix adds a check for an empty receive queue in addition to the
> >  rcvbuf comparison. When the receive queue is empty, skbs should stil=
l
> >  be moved to prevent the stall. With this patch, all mptcp_tls tests
> >  pass successfully.
> >=20=20
>=20>  Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  net/mptcp/protocol.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index b6bafc37eea4..054aa72c9aa6 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >  @@ -739,7 +739,8 @@ static bool __mptcp_move_skbs_from_subflow(struc=
t mptcp_sock *msk,
> >=20=20
>=20>  mptcp_init_skb(ssk, skb, offset, len);
> >=20=20
>=20>  - if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
> >  + if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
> >  + skb_queue_empty(&sk->sk_receive_queue))) {
> >=20=20
>=20>  Similar consideration WRT the previous patch, we need protect agai=
nst
> >  possible attacks. I think checking and allowing in-sequence skbs sho=
uld
> >  be enough:
> >=20=20
>=20>  if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
> >  MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq)) {
> >=20
>=20This patch addresses the blocking issue that affects the NVMe-over-MP=
TCP testing.
> Could this fix be considered for merging separately into the export bra=
nch as a
> standalone fix? If that=E2=80=99s acceptable, I=E2=80=99ll prepare and =
send a v2 patch focused
> only on this fix shortly.
>=20
>=20Best regards,
> Gang
>=20
Hi=20Matt, Paolo:

Please note that v2 of this patch has already been sent, as it is a depen=
dency for
the upcoming NVMe over MPTCP support.

Thanks
Gang

> >=20
>=20> /P
> >
>
