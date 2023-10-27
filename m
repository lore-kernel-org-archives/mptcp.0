Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42901773E
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQHgnZ+4"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7789aed0e46so160161785a.0
        for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698417768; x=1699022568; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM7w9lbTQCScKfaQB6vknoOamNn9hyD1LztGLf7uIs0=;
        b=dQHgnZ+4xjbul7j9/4bX6Bw15jUwLSKePi2EISrwJEVrNRgFb/MDpUqVg1LWNfutQS
         QUBKxoxyrwiqCRAyqr7S1g3hFMySd0U/OWDgQNXujxTypOKcRfr545G/isXNzOqXCtHP
         NbdnalVo8M3Rfxpv7yLLhzDW49wUpUDy/ULrusADJzys0+U/VyErlLw29/LecWyR6QTd
         pHxyVrRrMPW39/XbRS2/+b5wcf82hdCQBddbwe5VbdJD9DdhJtHzrFh/BsqeiSlAdgD0
         c0vommhf0+VnKn0HkBqkbWvZa6yZ6IfqTrtEZFF1yRJjAXIevMy3ybP5qmbVU5IPTHyu
         iZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417768; x=1699022568;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM7w9lbTQCScKfaQB6vknoOamNn9hyD1LztGLf7uIs0=;
        b=S2Os0t/e50alVVJ5cdEp3/B4egupNCeoQOqakpoaGRof/Dwyi1UnfIu87z9WTUrpA4
         h+Y+wvSekkKarCWjx/8JI2hFhXm8AFq1vHAPCkPtUa6J4uggiSb7GxmaXnRgt7xN6ZUl
         BkDvNQ6jqvLlcO9yaluwwZpCg1k/SgP12aOXrqFdRGb5DQTv8pzKq2qLWk6u+abcBkK2
         8NV8Q480wlalWwKLNVcwaAcsGZhTmxxbix/CEvdQBfo+Yx6UCWcxLE+Rm7X1+t+QpH5i
         gmoJ7E+KR5vWfRV4zbxF352Ld4kKggpYDiyFcuuxYU6//v1FJgEXufxsrjlfSSrqz77J
         sOEQ==
X-Gm-Message-State: AOJu0YytcycL0IbK55C5ytKEKJrt8B5GZ/JjA0Jp5wbWYQcYRLbhm63f
	OYm76SkBtzkuznwP4JN0Vg==
X-Google-Smtp-Source: AGHT+IHg0IU6Fo7DnylPAj2QjhdoUwftZbBNil/oN/VM0QSDF7S7fTke4QeWtzXjIN7rISbGT1Njmg==
X-Received: by 2002:a05:620a:d86:b0:779:d0d5:67a8 with SMTP id q6-20020a05620a0d8600b00779d0d567a8mr2829882qkl.17.1698417768461;
        Fri, 27 Oct 2023 07:42:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.255.8])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a08db00b007743360b3fasm597833qkz.34.2023.10.27.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:42:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
References:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
Subject: Re: mptcp: deal with large GSO size.: Build Failure
Message-ID: <7dafaff8-20c1-be33-8044-e05d01a1399d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2023 14:42:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/6668654076

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/3ec0ab8000=
a0

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
