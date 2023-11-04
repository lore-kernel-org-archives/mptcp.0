Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7610E3
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgGa4xd0"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-66d12b3b479so14773406d6.1
        for <mptcp@lists.linux.dev>; Fri, 03 Nov 2023 17:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699059591; x=1699664391; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQCxpUR+HSFYZGOZ6LNF/vIZ8UQaDsdHDX4rlSKml8s=;
        b=dgGa4xd0ki4lQOsKFmG2iA9dwhIdu9dvrwsDSTusPpi+FgDH9mmbX7I2ycxFMAFHge
         bLRBZoBhrQ0UOwGwoQXAaSBz6/pfre4sdPLuTx2XxNsPp6a8uz7zIwXGJ4UfNoebTUyR
         PFuaVfJP/VyaTe/0In9WSNnqnJ3Vv1yllVC6cuS4NDCMbBMdP9XDudi5RJa3WIuciuuh
         r5n0MZR/nK98YCQoHCcnTtEqyA56HkJK5TAqJzsz/JblXjEK9Y4rAdZ+9GYZe9s+bIH2
         bcJOYH+5CCJe910e8u2vBf+NW9z/rj9jgisJ9tZCYU2/29nyjvRNYCaHaWlP+QXFZ/Gg
         Jw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699059591; x=1699664391;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQCxpUR+HSFYZGOZ6LNF/vIZ8UQaDsdHDX4rlSKml8s=;
        b=d7QmdydAvOC8CegFqdWl6Z0GwQfNnW0wLs2WjbjbrmSozp645VNhJssDzI1I5pFTb+
         AKpu9LHUeUrc1v3m3EZ5jCJtdupR8wrgb8Optnhz7rP6bGW7BAcTmMlYYGyUs9nFwL21
         HgGzHCGVnzrqKCE1oznyAHf6fJkKp8czxDTxY8w6/+qM2Yo/kMEOZ7qjxyQuXrXT/3jD
         5KNsuxHaE86Lv5LQcaFCGtfuAXljofBZCrfPVCB3YztPGlUs9aadVjc4mSTBQ8Mw5YFS
         Ysm7O8PAXqlBBEkaBGQ7sP9NU0LEH99Zz94e7q8fSIL0RtdOXMZszbZ/X8RxtqkFt2ik
         B7GA==
X-Gm-Message-State: AOJu0YwK7hnw6Np5k8x6WwqGU2WpyyTMjESdoQyFJXFX14Ys16OCVOhp
	ZFfFjaGoasok/63s15MIpbviRVbj7Q==
X-Google-Smtp-Source: AGHT+IFNXEAsS0er66PK3QBgh9nqPUucN3ZorgV+8yM32bqDmCLsHNV380UwssiSTOVf5xk4z3wmSg==
X-Received: by 2002:a05:6214:27ce:b0:672:118e:e368 with SMTP id ge14-20020a05621427ce00b00672118ee368mr19267488qvb.24.1699059590888;
        Fri, 03 Nov 2023 17:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.200.62])
        by smtp.gmail.com with ESMTPSA id c24-20020a056214071800b0064906cfe430sm1226151qvz.135.2023.11.03.17.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:59:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7492afacaedb042947485e17c1797558634ba60e.1699057244.git.geliang.tang@suse.com>
References:
 <7492afacaedb042947485e17c1797558634ba60e.1699057244.git.geliang.tang@suse.com>
Subject: Re: mptcp: drop lookup_by_id parameter in lookup_addr: Build
 Failure
Message-ID: <d00d2328-eaf6-cba3-5537-99e0dce00ffc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Nov 2023 00:59:50 +0000
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

  https://patchwork.kernel.=
org/project/mptcp/patch/7492afacaedb042947485e17c1797558634ba60e.1699057244=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/6751622093

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b9ad5e0800=
71

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
