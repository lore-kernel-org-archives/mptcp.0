Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434F2D978B
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578481; cv=none; b=CLdyDQySkKjFyLQP3hRbTuSGZfijnVpql7RTh3ae9h0v2JJyNSLCKzBE34T0zAuH/DIx+jAToZVEk2fvQoc26XB51D6fMAH9vtyBgzDLBNkDsLTWmf41n4SUWZnXRFmSZmf01Ec82MXOdXJ+awYxzT0DthJMitjVI9ro2l0RaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578481; c=relaxed/simple;
	bh=I6gelfCpnclDAOXLYsTcitx5rsilL8eTaT2mA5wnpOE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X851HZOfNAStLiQDjDW8dWmKQc4GtRLbst81WzBaP7e1opxXiWudpuLSONzCA9+1yHj4GWeJqyjY2jPNqZrSb2vEFvLVTDqn9zrjBEEXe1DDvbBDUUrebWFJXSofN5kya+rXyxykRHrbjLaBbmsEcJwayMm0By8tIGgV9udIb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHKEL/jP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHKEL/jP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7423DC4CEF1;
	Thu, 11 Sep 2025 08:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578481;
	bh=I6gelfCpnclDAOXLYsTcitx5rsilL8eTaT2mA5wnpOE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=UHKEL/jP/GFrWuuJpii1imJPYf1RS+J93zbd/MIfRE9xlo+oW5lYsYSQU+90xJZWa
	 fMJ8FTjSlTJksKcb8x8AefEJBW1l8c94W+gphQCSWZAT1H74nVOLGv+iki1pZwTXTW
	 c2PP1xJaoctfd3AolObI8f0LVnZ+6JDoYaqlHip1xJ13wZ0sRzoWLePh7Q0alVgPfX
	 GVuuHzRIx2uUDbYNB5iUw39pDqIorEd9pu2TDNCFxRYlOaTpQ1gzvXhOaYgimvmWJ9
	 sa6A2jDDCVhivg6ZpAUAlyoS9lwA2spy1AKpXioHoMbUk6CmgWtK6hfBJKFgeT/jnw
	 DmGIzQZmZ2Z4A==
Message-ID: <2de89e44847874027124a6e14f610ee723ac12be.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: pm: netlink: announce server-side
 flag
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 16:14:35 +0800
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
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

Thanks for this new patchset. It looks good to me overall. I have two
comments in patch 1 and patch 4.

-Geliang

On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
> Now that the 'flags' attribute is used, it seems interesting to add
> one
> flag for 'server-side', a boolean value.
> 
> Here are a few patches related to the 'server-side' attribute:
> 
> - Patch 1: only announce this attribute on the server side.
> 
> - Patch 2: announce the 'server-side' flag when this is the case.
> 
> - Patch 3: deprecate the 'server-side' attribute.
> 
> - Patch 4: use the 'server-side' flag in the selftests.
> 
> Based-on:
> <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (4):
>       mptcp: pm: netlink: only add server-side attr when true
>       mptcp: pm: netlink: announce server-side flag
>       mptcp: pm: netlink: deprecate server-side attribute
>       selftests: mptcp: pm: get server-side flag
> 
>  Documentation/netlink/specs/mptcp_pm.yaml         | 5 +++--
>  include/uapi/linux/mptcp.h                        | 1 +
>  include/uapi/linux/mptcp_pm.h                     | 4 ++--
>  net/mptcp/pm_netlink.c                            | 9 +++++++--
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 9 ++++++++-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
>  6 files changed, 22 insertions(+), 8 deletions(-)
> ---
> base-commit: 12e66f7051b4b535a990cd20c149d76a98ec68c3
> change-id: 20250909-mptcp-pm-user-server-side-flag-214c84b90b21
> prerequisite-change-id: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f:v2
> prerequisite-patch-id: cc65204dc8620f1675f8b8cbdf6dc0fecf20379e
> prerequisite-patch-id: 88640c51fc66f4d630e2f99db72c18830273fc83
> prerequisite-patch-id: 5773e6ceede07a2c43550774eddad1c32cde67e0
> prerequisite-patch-id: f9196f35eff69835799db4312e82c795f1b15eb0
> prerequisite-patch-id: 8ec26f3fe4baa5128ac2f01f7284184bbb0e651b
> 
> Best regards,
