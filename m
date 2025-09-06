Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41062F4F1
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168293; cv=none; b=ZkcviLGhvFs1oN1X/rsXwYCAkyZUQ6qDDicTxXfKhUZYKg7Oxbkea56e5gZiVLyYgi3JhmMc4ioo8WTEz28UbZ73ybXiVKGhPqSJSEVPUuSX+RqJuvIlRqU5s4Cov3NH0OiToF/javgUhy4uBz1BJaeNJtFE69pyzFVyWTuEZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168293; c=relaxed/simple;
	bh=DhsWzRd/y1W9ugFZAexJhGqlHORUB2SvMNRdbrGUs3U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dU2qdd3Sx7DScYzpzBhOAZolDAODtqJhC/ivA6WgsynbP3CsM6S1r1iL/5PSmjTowtB1OGYiwE2p/kF4LCqDhy+JbZHzlC/si/AjC/avil8BdbcDlic3qRrgV9fjS4/B9F03HP49xM0wjiABls5crZhgYU7Kt2mcLPPcU9X95+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaJEJMBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaJEJMBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A476C4CEE7;
	Sat,  6 Sep 2025 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757168292;
	bh=DhsWzRd/y1W9ugFZAexJhGqlHORUB2SvMNRdbrGUs3U=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LaJEJMBumKf9I/iUUS+0rmhHI1cD2utvILVbpilQrh6k8hYykfPSK/LfULsDLnps6
	 7TKbvO6m33A9Kj+sRiY784OuhFBjA/PAkN1H2SFMhnyIAd9rtlr/9YnGWhHv+lufwd
	 fpjKlURaOUPYjzLpmL386TfJr/s4NOkCDOy+zRy2cmPyXfta/g26Cf4JVZfHTYR2vf
	 MSRDmf18vMyTuSx+zO3vGb9O3XnKQ9pqqXXbtOiqvwi6xEhjQcOs+t+ninDZqSM0WD
	 he1ybxvEXIACf7VmXJNNTaWW68NxIgevGsErb8vA/fQ81HELbjDz6+aTZsIB5Likzg
	 ByBvKjGi8AAXg==
Message-ID: <ef9a1b1039e5e530b9dfdce218ae0697af783e9c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 4/7] netlink: specs: mptcp: fix if-idx
 attribute type
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 22:18:10 +0800
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-4-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
	 <20250829-mptcp-pm-user-c-flag-v1-4-78b25dda7708@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-08-29 at 22:33 +0200, Matthieu Baerts (NGI0) wrote:
> This attribute is used as a signed number in the code in
> pm_netlink.c:
> 
>   nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))
> 
> The specs should then reflect that. Note that other 'if-idx'
> attributes
> from the same .yaml file use a signed number as well.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for
> mptcp")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Patches 4-6 LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

[mptcp-net,4/7] netlink: specs: mptcp: fix if-idx attribute type
[mptcp-net,5/7] doc: mptcp: net.mptcp.pm_type is deprecated
[mptcp-net,6/7] selftests: mptcp: shellcheck: support v0.11.0 

These three patches are relatively independent and can be removed from
this series. They should be merged into the export branch first and do
not need to be included in the v2 iteration. I changed the states of
them as "Queued".

WDYT?

Thanks,
-Geliang

> ---
>  Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
> b/Documentation/netlink/specs/mptcp_pm.yaml
> index
> 02f1ddcfbf1cfd81a398dd03c52bb9f281c1aa08..d15335684ec3d6256505f2b3887
> ce5818eb57462 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -256,7 +256,7 @@ attribute-sets:
>          type: u32
>        -
>          name: if-idx
> -        type: u32
> +        type: s32
>        -
>          name: reset-reason
>          type: u32
