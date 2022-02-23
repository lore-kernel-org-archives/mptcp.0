Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACDC63
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 12:15:09 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id b13so4086653qkj.12
        for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=c6HBqY/9dsRiSElpMuWFhsfq3HXg/BblyUIELQme/Ro=;
        b=SRw0V2Dw+gK2bGrYshvbJAK6SOVVuj0f9s/dsqEEU/+wg3ODyDIpIKqiZaAjcp6UVa
         kFCIj4t/fvFwbikNMa6e9eUj2FmW0mWkrxnLrWNSl5nb0QFDFEo/Bte9k7o8Ym85iGSS
         sjtp/tVpZbbr95OIPvgVgyosT8iZbNblKsKjn0rkNg5ukVF7iCthSgCwWFTyul2zeOkM
         493rgP3cnM+fLGYhHoPDjK13lx/Shjv2ro0e+qc0kYLFnPsxDkBeojNtvgcprg/LGAaE
         ONVVyArICZ8INdQf553YrcaXcP9/zjsEnUsE7PLRE5+wJmKWC5H2B+MPQqjQo2cDrngl
         x06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=c6HBqY/9dsRiSElpMuWFhsfq3HXg/BblyUIELQme/Ro=;
        b=WkQGgtPRAoSpHAgYor9Vxmf6ZYuuDTXc9iBd+zCEwlC3Jzy20tPAGRaN2jlzc+AM0O
         IFUGpzW6GuiyE2PbIPV4bUswMHss7kh+Py8BdwMUpjBvfsqsZzOy5zp1hf1GPgADQTL/
         fci4zhg8IUknZQB1+fdUOi0oCph48FMm7FLAa/luzswxscmg871UDntp8T2kHYo4yNeb
         j4oBxIdud9yXvjQin9RsecbU5Ai8avccmnxLEGaNvjF8zvmu0i0pb4iCyGKvlVbKb/dY
         ZkB/2WyASzChTvBNnGdsHLZNgmRocRvCt0AEDxHYiG2gjZR/i2oLw7uREpa/I3pOif1O
         nTOQ==
X-Gm-Message-State: AOAM531cmLYTkEeBoZggMHO5wlpRu2FLopWl2U8zmJx/RseV8qkcz4mo
	YIqEg8MkEPQP+6+BRqwgfFD3Y8mC0w==
X-Google-Smtp-Source: ABdhPJz3dqoJdpOe1lCMp/vWeMRKqdh6g5GVsQuMJQ14Re716bRvrkNzZY0BrKbrrcBnSbwXIE2VEA==
X-Received: by 2002:a37:e303:0:b0:47b:b0e1:fc3f with SMTP id y3-20020a37e303000000b0047bb0e1fc3fmr18393312qki.108.1645618508007;
        Wed, 23 Feb 2022 04:15:08 -0800 (PST)
Received: from [127.0.0.1] ([52.179.209.55])
        by smtp.gmail.com with ESMTPSA id d18sm1755541qty.70.2022.02.23.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 04:15:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220223110832.29357-5-fw@strlen.de>
References: <20220223110832.29357-5-fw@strlen.de>
Subject: Re: mptcp: remove per-address listening sockets: Tests Results
Message-ID: <6f2820ec-59e0-b2d1-b4e9-bac81014b2b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Feb 2022 12:15:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5387982931755008
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5387982931755008/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6513882838597632
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6513882838597632/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6834771c3ba3

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
