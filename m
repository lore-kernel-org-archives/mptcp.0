Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9428E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:21:59 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id y199so6794260pfb.9
        for <mptcp@lists.linux.dev>; Sat, 28 May 2022 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=HzBfAu9lQ7VlVj8arVLZ9m7LyY/4gBr/XZ7b9sIegQY=;
        b=RiX0NIpmH+46QAg/iX1CnexeYrywuBcFO2cKrQseEaaDd5MLkSlf/+0gOGD+dXw+dP
         znq3ix1TBl9GnvNXtpBOywIGSDBF5j5IPysc6nvNc3C0J9pxE7zFz5igEPgcDuuYNicn
         0HmyarJwbVKqWBccDkEnMznyh+aY6PiI2BA1PM1GLyBMRDZhstKs5+rqNxT31m2QN7Mh
         3p4wQkfan0IOTDlvkJ9Yskru8MbQNSw8Vk6e2XDgeyuVh0j+lbAnGmW7ucrMTrV36emF
         F0rJnmiGBOC3H6v6KDDDVIahzG4Sp3KwlUr5NNJLYDHC50IB6+pZ5lA86oQ3xtX4azZo
         /zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=HzBfAu9lQ7VlVj8arVLZ9m7LyY/4gBr/XZ7b9sIegQY=;
        b=x9iIHHpaNDeUF8LZLMzPvsTVMZOvh1mjtARhuootPBO+7RzP1HGpku0kecpXHsQk2V
         wJzLVYQwRdW5NdjwPC8uQ7G+9/CZudnbLxn2PMkORFELT9PPm971zcYC03mb3fvZjIEJ
         NFXEJMJQcBmUoHMXTZWmcKKYALbLeMNqRlsNyYJ93MCqRsGxr6vg/e5oXZp5Z18WtSjJ
         Q93lS8PdFOkV4xxXWpvxc9Tr+wPVLutBUhNqbELnh4KOIkGwtOA45lxgDkfn5xfsFKzr
         LVzMQEfgVtS4cCPlSaU57G/4PtzRCvGwEMTsuGLdKaaofS32+QE+9mzxBqScfYz9Kh8b
         5scg==
X-Gm-Message-State: AOAM530Da50p7hgSvvNddWfDdNPf2GRfwjhtWqNK5tqXzq7DTrVyiZCs
	Ggk42GfysMHb80H0bggnUA==
X-Google-Smtp-Source: ABdhPJzG8DAwpv249jDZYMtTCEEOTWWy1Wdd2kYzM4gImUq7OskpfNRTIIVmHPTd41Hpa+4ELsvcuQ==
X-Received: by 2002:a05:6a00:1946:b0:4fe:309f:d612 with SMTP id s6-20020a056a00194600b004fe309fd612mr49272926pfk.10.1653751319270;
        Sat, 28 May 2022 08:21:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.196.207])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a019100b001e0b971196csm20488pjc.57.2022.05.28.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 08:21:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1e2b27869e72af5e2928450ff6216f0d78d609da.1653750351.git.geliang.tang@suse.com>
References:
 <1e2b27869e72af5e2928450ff6216f0d78d609da.1653750351.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Build Failure
Message-ID: <f28fefd1-4e66-d5fc-98c1-3f8094902009@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 May 2022 15:21:58 +0000
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
org/project/mptcp/patch/1e2b27869e72af5e2928450ff6216f0d78d609da.1653750351=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2401426843

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/982d66320a=
49

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
