Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA89CA71
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 21:26:30 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77575531382so232120285a.3
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695936389; x=1696541189; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A2lr4wwyR7w4BN9P5iD25z8RnTOTYYFGkAdVK61LtM=;
        b=UiyUFjFYLMER0txzm3bCOIRI9NWr2cC11HTxU0EUHtJPym5PfIW8RMoE/kcLmP8xYJ
         iCxu5B2/akTj3yERsrvyX75YAYHIwiEyXhR91HnZVn9OENcgrMj3fgwe/LHZ/sm6PleM
         YqG9FGY+Uob9hPhyTzPcs3ofVYR7m9LDA9/sXcZ8qpo6XtdBO4QQYWb7Z8NTgZ8djFsP
         jPwUFm/zfTSbjnZQVkzHgL8zWGnBJfolw1+ILE9Ye63V+C++LzBCMGPr0OMuP5XUufZT
         WusKXEkJF+Q0W7NWcmzE3khsPNu2/HlpVjeBJpkYDNiEBoQGyy+INrimvILpmzcniDdT
         mutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695936389; x=1696541189;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2A2lr4wwyR7w4BN9P5iD25z8RnTOTYYFGkAdVK61LtM=;
        b=Mo3pkA15seF1hkBdjhsrbl8QGtaVH8Ip9fOmECqDe4eZUbtrzHe8CnSr7RNGc8f0PJ
         TbGj1Q1G49wQbPvdko7rmjXb84YWS2ZxkJ5KSqcvErDqyJyKQfly2rs0Z0uYyg1X8/zp
         qyir8SSAgBFcucrD8NHMpipGvA/oYErLED2bOfhBKIOrtf5syij5di9aR74PaE9HHxW1
         RGg6HYzZxptXiKmh6Fgt3awugw6LluvVeQan6L/8BhvnRGKfrF00EWYBaywOyI8bQyou
         cvpBy9+J7Z+k4RcVmRj8BYTsfbMRuVCaY1vflV7YXEKbSXWpuRnTXkkNvzQrUefWT02E
         wIqg==
X-Gm-Message-State: AOJu0Yxkk7C/ZklyhjS71wMwb+NePus6TWVQaos6jDZI1lHpkorKnvXg
	5CDwmwbZKerikPal+07o6w==
X-Google-Smtp-Source: AGHT+IFaNhmnHrs2hC/z7E1u6bXE6PmU40O+vAOdpAb+rJJ4c88PxK/M2YwgQ/f8PkypzIeKEfTDQg==
X-Received: by 2002:a05:620a:4ed:b0:76e:f5ef:daf3 with SMTP id b13-20020a05620a04ed00b0076ef5efdaf3mr2409150qkh.68.1695936389080;
        Thu, 28 Sep 2023 14:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.202.160])
        by smtp.gmail.com with ESMTPSA id x26-20020a05620a14ba00b007756c8ce8f5sm1982984qkj.59.2023.09.28.14.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:26:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
References:
 <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Build
 Failure
Message-ID: <a55e7cd1-dc7b-f040-db47-03b477b67fad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Sep 2023 21:26:28 +0000
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
org/project/mptcp/patch/de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/6344241510

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7489646e8f=
f0

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
