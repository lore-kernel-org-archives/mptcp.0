Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0917EA
	for <mptcp@lists.linux.dev>; Fri, 16 Sep 2022 01:35:05 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1278624b7c4so50099370fac.5
        for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=7jQezPPmCy5IehwJ5jv535SVoUkslxcFt+Ua9NIbmQU=;
        b=byNGkLln395ulbgVSPkzLkYaTxPrabezCzU4uOD2OMw8viR24Z6VzwsOQBQm145RMl
         OAn/f2DN2fGc5WIAzXn1MsgfexXtqdXuipEWXduwYe1pW09Mxocz0X9ZQXHfDhnjizG6
         o7rJlmFVPOgB/cljUeDgoN/yCtobDWA1eyCPnnbEeYCVyB2HxYISeuLgzPQkbENmsHaC
         ZdOg8h/+2pNmsg19CNFpuhf9hYmxfdaxGxdaacv8wvuOhBMZLn0/OK2G12G+WrnJMiac
         BRzu5PsuweEvjwNmpJ9i8gJ5lKqI0mcMQcjovIRqrMXOHLvheQDjQVdUqBfymEuHDb2I
         Yjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=7jQezPPmCy5IehwJ5jv535SVoUkslxcFt+Ua9NIbmQU=;
        b=kvuxsYqWuczVmGWXA7hO6pHQw398JHFTukySyQeIBJLVVTz2xw69ZdRf1tMzhiNqFU
         MEdBe8KgqiYBr9STG4CEASDxHq10um2PpSsbMVfggUYOUY26bit4qkUN+WbZdpMLIFmc
         rf4TlD6fvF+8/8AwqXXw3VNFF3tM2oYWl1eC8IKsziFJCC7SchCiupiwrs0zSUD6M3/d
         Cx8LudaFjv37NLUj3jvrwYcBzN/+SNJTauGpA5z7vH3JsmpPYJgbiiCbL/e+BT8Xzqvc
         6CRdusXNul3M1ZhEigIX2TKrG6zICsq4fBZlWRV09gYnZ7OKCUUWYewVgCI8NzoZ67gG
         IMDw==
X-Gm-Message-State: ACrzQf2OSMfe2Bme42BdECcc9Yopal6+g5OpD0Gfd91LEAPZPJ+LiKUc
	kNH+QQxK+IaQItlCbnGjRUuVhhhP6A/m
X-Google-Smtp-Source: AMsMyM6qMyrbMTidHDxCOceGjv4WQbsJKV9It75FBXDu2ahaSV/zErN81JkloEyQ4NeggUZgR0jTrA==
X-Received: by 2002:a05:6870:b28c:b0:127:ad43:573e with SMTP id c12-20020a056870b28c00b00127ad43573emr1501325oao.174.1663292104578;
        Thu, 15 Sep 2022 18:35:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.85.74.194])
        by smtp.gmail.com with ESMTPSA id v36-20020a056870312400b001227148da8csm2187891oaa.36.2022.09.15.18.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 18:35:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220915235604.26018-10-dmytro@shytyi.net>
References: <20220915235604.26018-10-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Build Failure
Message-ID: <f6b17b4d-5bbd-bfff-347d-b68ea3bb7967@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Sep 2022 01:35:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220915235604.26018-10-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3064785105

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a04a47ac6e30

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
