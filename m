Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770220E1
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:53:38 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a3df1ee4a3so313386b6e.3
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 21:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691038418; x=1691643218;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAa/QjnL6mTIeWaR2xzATk+9K9CW7kdoslz7WVcGEwI=;
        b=F9urq9xKAo8So5SiQF8TypOQSu0fcLngKLpBAMLDD5tynzVBEAqo3ehJCfocwP6/B4
         094VIFI/GqLbD68/qfBrqF1TNje5X3P0wtSeTLxxYUID42qVJCDq0lFXJtywR4V6uHm+
         qeTq7+KfAx038ike4mPHUXjFwuAiMuUrgwJ7/V+53HdxfY1VDn2QV94gStRRifrcIUZb
         qU8pVzlprrBjz4CQb6aZwu9C4Qb9m3mJ3EU8NhS9+lS36Jo9Vvv9CTXqTjkTGCvOzW3P
         b43z6HB6CHr+fR3ZRFgf8AFkH7QtCvY4toBqMV57RR/vWjbLye6iG+efUJurylXlJh4z
         RxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691038418; x=1691643218;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAa/QjnL6mTIeWaR2xzATk+9K9CW7kdoslz7WVcGEwI=;
        b=LI7gTuRX8stnYMyAC3rvGt9FZ8Jl0u4cV4jdYxNkLvazmBmaxFnViunRCQbALooEc2
         UgVzSShXn/d4kFzacYxDihHfZQAz9y1vcRYHIECSVDzzdVmAru2dV49Bqx0gji7t+0FN
         hJDvK/JKxEcFgMLEv+vsWSsD65sXxTUQtpjF9wZPlB8YIrp+mFbvco29eaI8jZvnaaR7
         XcVaQiP3KLmPA29ScFLvUAxRXcOjzupz/VxmjeDUNU+xyVHHOJV5e9QkPhp2dR+Pn5Vh
         DcHsfqkzP5DOQYfc1g1OBExmI0TrzOctBfgqYmoAJyu7Q6vHHgevbDXHBbaPo4si4uzW
         ry2A==
X-Gm-Message-State: ABy/qLaBiaEVYyZXU5rs57XoN9tBhVWEQM8q24kx9qKxy7Tu0FCDG4Z6
	vSO3XbEmT4aJP3lV1mR2Zg==
X-Google-Smtp-Source: APBJJlG5o8gFx54bu5LZ/EoCH2hKwyWOv+LRyxTSiRXg9NOd+Ekdmm+DDSF6ZSEeoLL9Ym73w/xBlw==
X-Received: by 2002:a05:6808:2904:b0:3a4:31c6:7650 with SMTP id ev4-20020a056808290400b003a431c67650mr15741162oib.26.1691038417922;
        Wed, 02 Aug 2023 21:53:37 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.140.45])
        by smtp.gmail.com with ESMTPSA id q26-20020a056808201a00b003a3b321712fsm4656702oiw.35.2023.08.02.21.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 21:53:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4f65c2b44b82e8682abcf5c5b91dceced0f07480.1691036765.git.geliang.tang@suse.com>
References:
 <4f65c2b44b82e8682abcf5c5b91dceced0f07480.1691036765.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Build_Failur?= =?UTF-8?Q?e?=
Message-ID: <d860cee0-b2b5-8fc2-c51f-78d57484ef72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2023 04:53:37 +0000
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
org/project/mptcp/patch/4f65c2b44b82e8682abcf5c5b91dceced0f07480.1691036765=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5746700485

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1f357c615e=
99

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
