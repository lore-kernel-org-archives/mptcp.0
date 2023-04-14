Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4ADA45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:33:59 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so38450b3a.2
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681464838; x=1684056838;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URJlW7U09xybUpZrrQEDE4M85br1wQsMqfsD6fRqvaM=;
        b=jqJ1AeJDXvxYUEbszTbf0gFnTB+D0e3A+b0Mm1KiTOjsFq9L9l8Yn1og/xGk5TmW1y
         BLI8TcU+8WT1YkHhyM5tdp5QOQSZSVX+5Ehj5CBRaVIX56EH9ukg6oLwGdoLVPxn+Bxz
         H0WtaiFwCqJFsCQE3fS0FsPAUVQL840ZC0pzwfmRZAy41/ixNrW+7oLTLo7B6fTDCVHH
         NRE5/jtBi/DsFtLyitCRIzzF4yCQ1fUKsS9jzmoC3uyUerqbRh4z9+6LiNZcAmx2wQcF
         6gfkLDH/SalzRD7D1QSHBlqvd0JsBXpjOj5IGHEL4ZwjjgKPXdCUy9ebSj/nAXd3ZORv
         G51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464838; x=1684056838;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URJlW7U09xybUpZrrQEDE4M85br1wQsMqfsD6fRqvaM=;
        b=KV31QrCKl4PdKP18xRuakIdsl6npsiyabTW9uM+QIQdGZe51o0HtUqhE74IMT13Zkf
         8/TEx0asEJ1aHWpuv1dFm/QBfzYWwPQHJBf3pSRQq1HTEEkjEzb9rm51H8jln5Xj53mR
         eeu+jnkKOpHv8pxwvamMqA7Enc8IpaymZIGXxN9ScvbSh/EPgK7LFDMRtpWBXrrzT8rb
         fteANBIQdKWc6Gfbvt8KrtPrdqHjjUz3wGFAhU5OYPnKWeJtLplU2SlG9ZTenE47Ooia
         2RF2CG9sHLusA8guus1jsJHPy3BJKKAyTqwBiGrk2tLrIAf/mAkSBlLAzWS3ex0s9CaZ
         ShHA==
X-Gm-Message-State: AAQBX9cThvJjcNbgX4hcN2avn+rkZRXg6BniMXwyNCLV9nmk3KJvr2gR
	MtfgVeRvn2dH7kGY9m5JHw==
X-Google-Smtp-Source: AKy350aPyp3Wz8eXTdXOZPu7MwqjHuUxHOHbH4XtlaBu6igvNfrrJlc3qfcbMECcD0oQ+Kb5a46m9A==
X-Received: by 2002:a05:6a00:1903:b0:635:6603:2534 with SMTP id y3-20020a056a00190300b0063566032534mr7234540pfi.14.1681464838635;
        Fri, 14 Apr 2023 02:33:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.133.138])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78d45000000b005941ff79428sm2708713pfe.90.2023.04.14.02.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:33:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
References:
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check userspace mptcp_info: Build Failure
Message-ID: <515fd4b7-f9d1-071e-c32e-d2e7180b895b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 09:33:57 +0000
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
org/project/mptcp/patch/3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/4698370517

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/aa4e473b11=
57

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
