Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8526159E
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401165; cv=none; b=hD+s/NApnsy/uf2g8eEA4lRhMrM3RkGQwdHu5Zydel70VE+1s7xhCKgtx6PSdTH/5ZYEME0WPQs5f8JurKc3YZMDGLeLbNq94L8mnxr5MBADkewrLLlJ7U4UWlThRzvXJi92KibNv6U+F5GVZmz/t/dWmBwoZgRPYE4mqWB2EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401165; c=relaxed/simple;
	bh=xrXpkB2QiL9WCH0lKnKVcIyQ+zQ+RuS3Bb+hsmMycRM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOLkQ0Gs7HuSkjnbK/W8ptX8ofMtf/AoJes5x5wtDDCCsOD+SXpeWp+fG2JE2coJSG+yrnHeuZXxSFJ6Rd+n+rdfi+E+kwogl7l+E1DkYa+J5XsYavpFMm3r3JF7et1uIVNayfQ/Bsk+4wU80hIrkXyD9PSh0D1A6vHhcpUcuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMGadaDr; arc=none smtp.client-ip=95.215.58.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMGadaDr"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=xrXpkB2QiL9WCH0lKnKVcIyQ+zQ+RuS3Bb+hsmMycRM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788401159; v=1; x=1789005959;
 b=qMGadaDr+qOXxmRUytbM3ujsHIfE0SRlTjxDkkPeGT4dVJ2BzXkoHfy4bIbaRqPBECFZluHk
 RTNx53fMeWdcU38XCBFMl8gLMQVh1zHEhcuBXVGw3ThmiBRtvAOy/qeMqVir4pAO/Hldez0gtbC
 Nh//7l03qOEtySlnusza8dXc=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 558332b522a502e2;
	Thu, 03 Sep 2026 02:05:59 +0000
X-Mizu-Trace-ID: 558332b522a502e2
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 10:05:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: mptcp: convert iptables to
 nftables
Message-ID: <apjWApxBPOXac1xa@fedora>
References: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>

Hi,

Sorry everyone. Please ignore this version patch as it was post before
I catch up Matthieu's feedback. I will update the patch with a next version.

Hangbin
On Thu, Sep 03, 2026 at 09:12:19AM +0800, Hangbin Liu wrote:
> iptables has been deprecated for years. The Linux kernel has included
> nftables as the successor to iptables since 2014, and every major
> distribution uses nftables as the default packet filtering framework.
> The iptables command we run on modern systems is actually iptables‑nft,
> a compatibility layer that translates iptables syntax to nftables rules
> behind the scenes.
> 
> There are also some features that can be set easily with nft, while we need
> to convert to BPF code under iptables, such as MPTCP add‑addr and
> remove‑addr suboptions. To make future work easier, convert iptables usage
> in mptcp to nftables.
> 
> Tested with iptables-translate to make sure each nft conversion is the same
> with previous one. e.g. for mptcp_sockopt.sh, the ip6tables shows
> 
> bash-5.3# ip6tables -L
> Chain INPUT (policy ACCEPT)
> target     prot opt source               destination
> 
> Chain FORWARD (policy ACCEPT)
> target     prot opt source               destination
> 
> Chain OUTPUT (policy ACCEPT)
> target     prot opt source               destination
> ACCEPT     tcp  --  anywhere             anywhere             tcp flags:FIN,SYN,RST,ACK/SYN mark match 0x1
> ACCEPT     tcp  --  anywhere             anywhere             tcp flags:RST/RST mark match 0x0
> ACCEPT     tcp  --  anywhere             anywhere             mark match 0x1
> DROP       tcp  --  anywhere             anywhere             mark match 0x0
> 
> And the backend nft shows like
> 
> bash-5.3# nft list tables
> table ip6 filter
> bash-5.3# nft list table ip6 filter
> table ip6 filter {
>         chain OUTPUT {
>                 type filter hook output priority filter; policy accept;
>                 tcp flags & (fin | syn | rst | ack) == syn meta mark 0x00000001 counter packets 0 bytes 0 accept
>                 tcp flags & rst == rst meta mark 0x00000000 counter packets 0 bytes 0 accept
>                 meta l4proto tcp meta mark 0x00000001 counter packets 0 bytes 0 accept
>                 meta l4proto tcp meta mark 0x00000000 counter packets 0 bytes 0 drop
>         }
> }
> 
> Which matches what we change in the script, except the counter.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
> Changes in v2:
> - Fix --sync and --tcp-flags RST convert not match issue (sashiko)
> - make sure drop is a number in check_mark. (sashiko)
> - Other than using one inet table, use ip/ip6 tables to retain the same
>   table and chain names used by the original iptables/ip6tables setup.
> - Link to v1: https://lore.kernel.org/r/20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn
> 
> ---
> Hangbin Liu (2):
>       selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
>       selftests: mptcp: convert iptables to nftables for mptcp_join.sh
> 
>  tools/testing/selftests/net/mptcp/config           |   3 +
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 142 ++++++++-------------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  51 ++++----
>  4 files changed, 84 insertions(+), 114 deletions(-)
> ---
> base-commit: 8dd2802091fbba563abec55e0455d0e5273c7529
> change-id: 20260902-mptcp_nft-b892782ef929
> 
> Best regards,
> -- 
> Hangbin Liu <liuhangbin@kylinos.cn>
> 
