Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FB18FDD5
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925858; cv=none; b=FzhoTzj9maXcXy5BzgrYil4/r3SQZAmzdA0Pf4RVL3KPo9Ye4DXixt/fI9olLDeRQBdZMdZggvtosPUkhcOqSPjQ+ryxjKyY7mbe9DpsK5SXYxkvcUmcEZQs7svHiR4VgmAjLvaMa3KqunayAIT71YE6W9o8U2IRYla5jPYw1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925858; c=relaxed/simple;
	bh=rU4Uv2l5gT1yCyVLdax4gKJs8HOkgviOhS9eRs64pq8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bej7ur7t7KCBxQzcIW1ZIq2Y3ZTGnROCfz/jkjcKA3YelFZh0AW0zIOOQsa+zte9mz85qUx1ZAiCGmVpymfYm19aQwgC2QSLOAPhQTnD50q5OOBzpKVdf8kgxopnkGi5nfonn3EXPxtuTu61ElF9HLhJq2RkEP8KPIsHtWNcCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/TsDnQZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/TsDnQZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e42f82ab88so20387606d6.1
        for <mptcp@lists.linux.dev>; Fri, 07 Feb 2025 02:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738925855; x=1739530655; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc4d8JXgsERlcSDEVJGd38iDBBJw94oapqZ2IvSVcv8=;
        b=l/TsDnQZ4QUZaNpa7YdWFSQPEKMGMMLFRpWY9NO1rZzlxpY4Ha5SfsrwfTI25v1Em9
         2BB+OvUnUku9h1rU+mWyrGNHoTZbFQwliRZPx7UBW6Mqe7Cq4NHv7BFiKzJlD/36gyrj
         +Fzs/VUZinRsauj6n/RQcywhjYOb8Bo+chOVGTU0MGH3arf18K6ZKMWS9UXrhM1AjScx
         g1q4cv2bPi7XCc48PMg/1889x99bnkzUavmMwhbJ5+Up2eUbDxXAk+aC2V0EwEaaK6Uc
         Fe4V3Aot9PYjyQJbVnporbWD0qVGaj3fJuXXHGlWsFOxBJxVbUZu4uBjc/AP4Y8pT0oG
         DHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925855; x=1739530655;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hc4d8JXgsERlcSDEVJGd38iDBBJw94oapqZ2IvSVcv8=;
        b=BYoxzxbp5nZL5qQHAOIEywXIZH/5qTsFVA4Z1RFgtxEm435DHGxC5/aOOHevpiaB7T
         5+Cc/PorPd0X1ML9AMQPn7oGLBzEd/PP6IKD1cpYinHrf5CKNyv90hk4CwHRHdMD+emC
         Kv1WPUhEQSS26NupDRFRlNMtQesAarNlvK/VK242EatTqohq0zR88XOYCBsOiBTUWofE
         +u0LETKsK0h5Ln+LiibUVgOcPkk407EmMl4PB10/Y0N1r2aF7+OJ61mDAHox/i9s2nV5
         TPqSAXgKZyzWBnns5/0jPl2IMqtbcawuP9uEP5rpkhtej6PtwkT1kUSGyjuULiZe4yTw
         wo0A==
X-Gm-Message-State: AOJu0Yy9CyL+2OfWl0kBSzm9fwcXICq62TVLQcAuBNpbx5DTX5RMNce8
	wMP7rJG3KuRNSvyCLvvUFJTE4kQFdB1Daq7XWo+P17pnRYdeY1gEGWUbV1s=
X-Gm-Gg: ASbGncu+YONRrDq1MRe7lq+mmLBcrBYwrzzo4CKyLWsZfdK0reSHvhx9UtEpMCzfxB4
	/jMDpoozqjSCTrADyzcSJJqTzqCIXQhR1DZzGGCEgTT2xDdo0GEsmwQZrl5t6X2ss7vMQjn5SEg
	XeCzW7L3FrLHtNmIWt9z1KZqga9dvdHOa0lUYfh0pviQRuExQg4rngLXylW8NUiAXJqLfgCrwot
	6sQ+AvDsNh66wUm4e/ZEe1k5ABIvRbGaPmoH6au0i6gUu/qLzym5R7AkQdTTscYEvRrcYuxkscy
	Lw1KPgvMJnw0MfP+O0CIpTg2kR4=
X-Google-Smtp-Source: AGHT+IGTPXi2/agcbuHHz2PVu+4trQ/ceqbWOwPXBu1Wb9awq/qCanLXZnbBSQ+3T59hJg6HcqfdDQ==
X-Received: by 2002:a05:6214:21a1:b0:6e4:2962:6d16 with SMTP id 6a1803df08f44-6e4456dd1d4mr46238256d6.34.1738925855438;
        Fri, 07 Feb 2025 02:57:35 -0800 (PST)
Received: from [127.0.0.1] ([20.98.37.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43bad7540sm15422206d6.123.2025.02.07.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:57:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738924354.git.tanggeliang@kylinos.cn>
References: <cover.1738924354.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/5] add mptcp_address bpf_iter
Message-ID: <2522ae11-cd36-0fca-bc5c-2d82c2d00c39@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Feb 2025 10:57:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/13198351456

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/bf=
5c2a4b6df9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D931534

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
