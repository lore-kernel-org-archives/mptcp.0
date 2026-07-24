Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BA429CD5
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888705; cv=none; b=RW4QG7T605lvM4APDF6RCklXD4C4rT1WMssIJ5rtr2T7F60l+sFeMSi0WBu9QJccLII3Tgz7hLnRpx1Rx757yYqwV4QZGf8j4lwSkDC7zdWJgbdJDrKztlzkkeEKUpcmY5HmwdWEsy9Q9lFAvTaZso6LKmB60Af/deuXMoy4G/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888705; c=relaxed/simple;
	bh=Gy8WwhwXyYWU4W02yPSiiY5F1u3DGxhchGdv1Bvn4yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU3VOFK0zWvytkN2HfS+e4wMwA2TYn97VNdf9wqpTj4b3a0oUK7MpuX2jmNxM7ph3rBdLgiH6vTctGJgAujWy4VvZDBom2X8kvxNsVGJJNMjSzuOBsavESx4nuTWRU2hx6FB9gnt3qi2q+zqJ4q+Z7MBnUj4IAxD+Sq2otD2inY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWAaIAEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWAaIAEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6872D1F00A3D;
	Fri, 24 Jul 2026 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784888704;
	bh=uLiv6xTsbDN8XCqXUPzU3rfiOVe2Dwev2zDIDIV8wnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FWAaIAEx9jDKfRZuDAwjoi9GvS8E5cZanRGNwCmXXmWO80Imr3VwgNx7gffYl7P/9
	 Lr8EDQcY8Qs6sr12Px3XG/JI/vex3DG8Jay18+h1A/CxPxjvz0mrh8gieb7aSFPxJ3
	 n+QoUlSMbxWXOIKNrwOhCyY21/cZS4/GQ9f1haihPoLumDFwFP18SfDkCHUHFzjO4d
	 VNKUDNR+GkGwCn+A+aAniOmvKfFVQ7RIWWsM+7ljOxg2sju1uB5aTA7hruryCBXZp4
	 cAqjKS3igjOD72zpnIbIT2gouZ2povF8uJTORJRh4mXsDkfs/LXDCQs6jKEFZJhHRH
	 FCp0T9h9bH7VA==
Message-ID: <190a8af0-1a1c-4bb8-a129-c245511f54f1@kernel.org>
Date: Fri, 24 Jul 2026 12:25:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next,v5,07/12] mptcp: sync mptcp skb cb layout with tcp
 one
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, pabeni@redhat.com
Cc: mptcp@lists.linux.dev
References: <8acd04596a44fa0a03e39f9f3d10a2e301b52763.1778446731.git.pabeni@redhat.com>
 <20260722100104.1241778-1-geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260722100104.1241778-1-geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/07/2026 12:01, Geliang Tang wrote:
> Hi Paolo,
> 
> Patches 6 and 7 turn out to be very helpful for simplifying my MPTCP KTLS
> support implementation.
> 
> To let KTLS obtain an skb's sequence number, I had defined a get_skb_seq
> operation in [1]. The TCP implementation was:
> 
> static u32 tcp_get_skb_seq(struct sk_buff *skb)
> {
>       return TCP_SKB_CB(skb)->seq;
> }
> 
> and the MPTCP one was:
> 
> static u32 mptcp_get_skb_seq(struct sk_buff *skb)
> {
>       return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
> }
> 
> After Patch 6 removes the CB offset field, the MPTCP implementation collapses
> to simply:
> 
>       return MPTCP_SKB_CB(skb)->map_seq;
> 
> And after Patch 7 changes map_seq from u64 to u32, the get_skb_seq operation
> is no longer needed at all. The two control blocks now expose the sequence
> number identically (same type, same offset), so I can define a single
> TLS_SKB_CB accessor that works for both TCP and MPTCP without any
> per-protocol dispatch:
> 
> struct tls_skb_cb {
>       u32 seq;
> };
> 
> #define TLS_SKB_CB(__skb)     ((struct tls_skb_cb *)&((__skb)->cb[0]))
> 
> static_assert(offsetof(struct tcp_skb_cb, seq) == 0);
> static_assert(offsetof(struct mptcp_skb_cb, map_seq) == 0);
> 
> The static_asserts guarantee at compile time that both layouts keep the
> sequence number at offset 0, so TLS_SKB_CB(skb)->seq reads the correct
> value regardless of the underlying protocol.
> 
> I have reworked the entire MPTCP KTLS series on top of patches 4-8 of this
> series. Building on the removal of the CB offset field, I also added a patch
> that trims the duplicated skb head at receive enqueue. With that in place,
> KTLS can retrieve the record header via skb_copy_bits() directly, so there
> is no longer any need for a dedicated MPTCP helper like the
> mptcp_skb_get_header() I introduced in [2].
> 
> Looking forward to your next version of patches 4-8. Happy to help out with
> them if that's useful.

That's good if these patches are helping you, but I don't think Paolo is
going to work on a new version for these patches. The attached series --
mptcp: address stall under memory pressure -- has been applied, and it
didn't need these patches at the end.

I don't remember why these patches were not needed, but I guess you can
always cherry-pick them on your side, and modify them if needed.

Cheers,
Matt

> Thanks,
> -Geliang
> 
> [1] https://patchwork.kernel.org/project/mptcp/patch/eacfe3e5929c07d35d08cab6663c61d40fac8649.1782123118.git.tanggeliang@kylinos.cn/
> [2] https://patchwork.kernel.org/project/mptcp/patch/447fc4384ba0d4b0f78c452239dbb3e87e021578.1782123118.git.tanggeliang@kylinos.cn/

-- 
Sponsored by the NGI0 Core fund.

