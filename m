Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D729B0
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 20:51:05 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id 1so17794017qke.1
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=xnNfwdkBGecM3L5rLdK1vvpPcXnVeqYM3WO+CdLIgEU=;
        b=GnOOogELSSi1NDNqP7QTAEZzFSb2tOnFmjfwhnCor8b+WRuWwF1ZvkmmVAQVau1Cc+
         e37+8HvTSHFmpQUS7lhQGxuVmVulNaB5rWQmGBCM1zkF2uM0KfXgjUqNPflpjoGlMZTC
         /Zon6iV9GOk/IBB853uWIw1r7fLOIIVHiieHPlGoGd6QmRCBfu6Hynfe+GVTZq6bXMMd
         IoIKWaBibEfkWoyUvhNyUP45a/L6SQX03A5hKnHRdngQ2g1qCqGk+4QDnSsaCIUamljm
         odoOf/fk3xK0njoRtD9a/g58S4kEGBsG6oTX6r/qSMGlxKP/iRbkc266Cq5k9CsaSTgk
         OtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=xnNfwdkBGecM3L5rLdK1vvpPcXnVeqYM3WO+CdLIgEU=;
        b=qFafvOM0ideh5BXMzAnRRmlxRue+z9M/HzGHbQFWp2IVgUZuDC9lyr1yEOzAy6W4BJ
         a34G3MZN/uSyHngHB+u51Wpv61s0Qamrl07Wqx9WayR1Qtozive+uaCg5wI4RUhUrSTs
         mT0vExESBrEi9iHHtSHG5wcCxfEZ5uYITs/ldg/eJwPIM9EgWHKvDzLgexY59sO9kCEO
         RPCGXzpgydKNLIIuTlowmlLviWxWsNwkxqUQTlsKutjVCdNEyjHx617bxZFiDmfm7jnu
         hBeIwlSbeV3D7JGh0YRrlCf3uMVz2wv5o6CDX3j9O41kBqgo0wJdC94itCP43NTHFAax
         dbBA==
X-Gm-Message-State: AOAM530o28ksi35f3LTZsG5EFQvEOQMVJZWX/YKHmvmZ6WkRYhSRn7Ec
	TOq17X7+L75vxhmxQ+ocZrVckNTSuA==
X-Google-Smtp-Source: ABdhPJxc8c/Y7c94cVEipPm7x7bvP6YDMb1Y21VBl1tDfIUxe74CbuW8VXubTITlnmpDkTa+LogmJg==
X-Received: by 2002:a05:620a:2412:b0:67e:c1f7:d2d5 with SMTP id d18-20020a05620a241200b0067ec1f7d2d5mr1151270qkn.440.1648673464012;
        Wed, 30 Mar 2022 13:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.70.72.156])
        by smtp.gmail.com with ESMTPSA id z28-20020a05620a101c00b0067d940a74b2sm11021068qkj.39.2022.03.30.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:51:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2d4db6f87d2a8f8be36140aa7feabc7cdea87ec1.1648223504.git.geliang.tang@suse.com>
References:
 <2d4db6f87d2a8f8be36140aa7feabc7cdea87ec1.1648223504.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <4f5e8454-f3fc-e379-4d90-8fe8cfc78125@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 20:51:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Critical: 1 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5707298617163776
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5707298617163776/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6604646671187968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6604646671187968/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fa5a338aa3b4

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
