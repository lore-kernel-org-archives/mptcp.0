Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977C3ED5D6
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947951; cv=none; b=GwKgj6QMUGSwxnETZehXZGMo5Slhpny9EgOHyHRQi/6Lb7FhAnXPTrYZclUwJv17JBC8Og9hVJhWQQgkQkF/Y7SgQm35cYBAYZBLNFqIbourVJDcEGRbZv2GR7f57avI+NVdaJDfVYDA7kOHwQwjYBPhWAr6upZC/EitO8JGLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947951; c=relaxed/simple;
	bh=+PJtUnUqMtakfpoukgNG6m5r2Kukgd+onZ0KysLCIY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUE5HdqzB3//qJDAa9RBT2ELZKolesmx/upRjB5X4LAQUxhqQAP2FjnDfkm0qEnRSntN6zzaUO0SzrgSbfq3cJXHuJiVEMZk1Wm0YQOHElg0SJM5QfsiX0Gy7yYu5LjQtXMUW7hihT8J6Be0TSEou2O3J8nRIvVCsWaP/2Dv55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzYDkXFi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzYDkXFi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2429f98d0so38710545ad.2
        for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776947950; x=1777552750; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+PJtUnUqMtakfpoukgNG6m5r2Kukgd+onZ0KysLCIY4=;
        b=hzYDkXFiBCaW6PaFPB8U7iI6m0Rm7VCkKYwxTY/DQJsyB9FSNHXCQExz4He4fW29js
         9VmPGKAHcHLfr2Xr6dpT96UsarbJy2DDSgcrKDdE8uLfin5PcUkWHcGOrgZpD/4DxPY1
         2pQNqaucXjm8Jk79ZWecvQxJOA6FKnDLS7RLQeA7Eve7vWbfDANInaE83uP0nyljak5J
         nktsJKaWKdqlGhxzMZBbEPWCuL2q6s4RiHzUKKx7d/NojcTOcrgaQ1TRcP2UfYNtoEFX
         G0TAG9g5+9uiuDnQljULI8CKr7t7cuKG+3BsBYmXd+lAyYxHDwzLJTnxphewV2sM5ws3
         sG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947950; x=1777552750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PJtUnUqMtakfpoukgNG6m5r2Kukgd+onZ0KysLCIY4=;
        b=AW7YFlzRBc6zzkol6ZCAefRU/WX7yH5KxoSil+ZSyLNVR/dg5Y9mv96t7fq4tLztrS
         aWfvvNRNExE5cEmjiRyHOtsdGQahcE+WlujfIIDFf8fM8muZsldBfkx713cqqqUgBY5E
         h62HlDOpECIITL4K5j3nx1Ms4ozGiKWGyhbL9Gmnu+v72LXVTiGaHgctf60+DCopmGDp
         VDgunHlKHBUXkepOIGF3IHHbPwuvOBtsKswxaNYQq975DRsW3OcQkFfVjMarPSEiwAe2
         JC3fLAW97TF3Ua6sIIQFoAH0GH598FD0enPimqKUwUwdx53jc7brsvM5L3IoGrOqHsjT
         ucRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OWWIfCtrnBSL0s1V3niKhtE07/pWAIdO6/BtVgmX+GiJWzGz52PpTVv2nLCZeCEzX2Z9CGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKJLeFE7uWOmKDTLw24LjKVtEdGEbD6AD5fzBm7gY0Yz3y3erI
	pqH3z/eiS7le30E3JfdFpeRjoe5qyo/ZpWkzlcU4Cy6pWVhpPfivyjKt
X-Gm-Gg: AeBDietmcf0299PnNm+58AHyPDm+7Xg4n8JtIi+RGy+9tcoznmXkhdQO5AL5gKaDZ4U
	fRHjkHAzo8ceMokPXv7kcmhiYgtxfGqMEmSdWiwRZu1nYGdnkK0FXe3MloNua71+vrmtUk76NSj
	qsWjRSwEmwJiVLNS5vMqQFXAXxmUYjjf7tWcgUC5jO6h7TziQbFDlJdQ0P/JStZHbLyPdRmXPhP
	8TOk75Bdnvgi15y0IR7yhH4obfsj1kCMSdJ55rDgpe1Ut3oG87wkOBRBBKl03LfTDVgqybjjgQK
	3tOVddgL3V5LNREUmBsj/VMxHHDP2W56qXM/sjV+XBpLcHfEvLpJflVfEpGeqSqXLi+xXFkjBl3
	u1bdAktmyQ7yTRT8ppi22ZgJ4KiWkT9kfPRJsSTvqg5a7WFVd1Kp7ZMrJoHP6eJrOB01hdF/JyW
	0CWNVtPS3Eh31zC5aSSn1bPC+FHVPJeOmE31N2Kw==
X-Received: by 2002:a17:903:17c5:b0:2b7:a08d:9e42 with SMTP id d9443c01a7336-2b7a08d9f73mr34404275ad.32.1776947950067;
        Thu, 23 Apr 2026 05:39:10 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c4fsm243138035ad.59.2026.04.23.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:39:08 -0700 (PDT)
Message-ID: <c646167562e802438abc72435f126c6bc7263ec1.camel@gmail.com>
Subject: Re: [PATCH v2] mptcp: do not drop partial packets
From: Shardul Bankar <shardulsb08@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, pabeni@redhat.com, 
	martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev,  linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com
Date: Thu, 23 Apr 2026 18:09:03 +0530
In-Reply-To: <88096a1b-0c16-40ae-a03a-0d0d7f1702a4@kernel.org>
References: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
	 <88096a1b-0c16-40ae-a03a-0d0d7f1702a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2026-04-22 at 19:03 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> On 22/04/2026 16:39, Shardul Bankar wrote:
> >=20
>=20
> Thank you for the v2.
>=20
> I didn't review it (yet), but just to let you know that there are
> some
> rules on Netdev [1] (that usually also applied on MPTCP side), and an
> important one is:
>=20
> =C2=A0- don't repost your patches within one 24h period
>=20
> Each version generates a lot of emails that are sent and need to be
> triaged. With the high volume, it is then harder for us to follow,
> plus
> a lot of shared resources are used, etc.
>=20
> One last thing, because this patch is not an urgent fix, do you mind
> sending new versions only the to MPTCP ML: to a restricted number of
> people for the first versions, there is enough traffic on Netdev.
>=20
> [1] https://docs.kernel.org/process/maintainer-netdev.html
>=20
> > A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
> > drop partial packets"), reverted in commit bf39160c4218 ("Revert
>=20
> Note: these two commits should not be mentioned here, they have only
> been applied to the MPTCP tree, but not upstreamed. Instead, please
> use
> lore links, e.g.
>=20
> https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.17630750=
56.git.pabeni@redhat.com
>=20
> > "mptcp: do not drop partial packets"")) also added a zero-window
> > check and changed rcv_wnd_sent initialization, which caused test
> > regressions.=C2=A0 This version addresses only the partial packet
> > handling
> > without modifying receive window accounting.
> >=20
> > Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order
> > queue.")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
> > Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
>=20
> Checkpatch is complaining that the author of the patch is not the
> same
> as the one who sent the patch; You probably need to run this command
> to
> fix it:
>=20
> =C2=A0 git commit --amend --reset-author
>=20
> (when the patch is sent, `git format-patch` will add a second From:
> tag)
>=20
> Cheers,
> Matt

Hi Matthieu,

Thanks for the pointers. I'll wait for your code review and address the
process feedback (recipient list, commit message, email mismatch) along
with any code comments together in v3.

Regards,
Shardul
