Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2F258E
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 16:54:44 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id p22so25480282iod.2
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=4L3h+I2nLzdIHYnbJjZoN1hr8ll0Kta1I0PcYu12VuA=;
        b=ZeTF2vJfb14bAW/iabC8zbZcmLlpdsUB622EPyGyqAgcmGM94zA5hLMd/7UmOHsEOZ
         hC3rX+OLY55odufR86L2in56FttqGxUHuqhXAE9uHmm/fBnlbZXUNYSbPGIMuB+Ud3VN
         heTpLU/yjHxBp0+5uOACz++K4J59FEfbO5nmnlC5up5Y4InMRJZAcXmgPzGxJOQbArO3
         vZBl7muJ+pAcsR1PqQmojEh2bBN+Y+Bug0Bc/GMsVB+O0wKiH2DVjbAfdy05BTRmFrxL
         cA8iantAsLGIrhGLUvlneRYrGjAfLDdvb8bU68PGanEDQNzLeCw22lF298CbyXMp8TES
         hwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=4L3h+I2nLzdIHYnbJjZoN1hr8ll0Kta1I0PcYu12VuA=;
        b=zX+elVWBKG9+faQZ7oRiIUsu1QgNEJ/wsYN12EH1lS0+MEN9aCjPcnqCICmKPa84m8
         x/bfoiqebyF4EEiBfrASB44438Lta9ZaoI8WqOY/7ju84hLm1SX3weFgoSdpFnCKKXHi
         Jc4j8S4GBtF78AK2aGfyb4clsP/pLvWC1LwWvmU94MX3PQd5wrLx01nT4xngTxVGRyRV
         d+cLdG52oXtvGwoEn0WW19NwWJ7bVxu7OIV8Q59zTEydF0Q6QmxZjTQXf4G09epSd8Wa
         YJ7vpDG8IH7COzKDYhjCsip8JSVC1jDfSpymajsRci2x/Au3HVJ6bM4leYBFATV3BuhO
         g7LQ==
X-Gm-Message-State: AOAM530ZiFqiY+D3EWOeg1tiOY3DUvbeyszjymlNrNAVa79h19/gKlvZ
	SOHXP8MDGEXUSpISX9TWbQ==
X-Google-Smtp-Source: ABdhPJzZPGAGIcB0lkNhR5Sg7nE86g9towfUeeiOX+jlNZE9Y6/tA0A+k9mMRgCC2HWjH0a/RKLGww==
X-Received: by 2002:a02:85ac:0:b0:323:4099:dee0 with SMTP id d41-20020a0285ac000000b003234099dee0mr344592jai.189.1648659284042;
        Wed, 30 Mar 2022 09:54:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.135.231])
        by smtp.gmail.com with ESMTPSA id l13-20020a92d94d000000b002c86662a286sm10606987ilq.22.2022.03.30.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:54:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5ec49efb1dfd2777e779bf4362c6bbe67d89089c.1648537203.git.geliang.tang@suse.com>
References:
 <5ec49efb1dfd2777e779bf4362c6bbe67d89089c.1648537203.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Build Failure
Message-ID: <989e00c8-c3c8-8c13-eb07-3ed3c09ca0f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 16:54:43 +0000
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
org/project/mptcp/patch/5ec49efb1dfd2777e779bf4362c6bbe67d89089c.1648537203=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2066153213

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8b1e8ed0e5=
7e

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
