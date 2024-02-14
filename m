Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED952F63
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914915; cv=none; b=aUAYKE8+chZJ+8p+rmyoFUhIaSmGjx6qIwJ6yaAMGkgsHJTpZMSYCIyePnaEoqym9NtzZJCpLhAXO/OF2+OF6CLQ0ldZiWDOsRYL8YtITS/OjhJwO0aiWMhSkGic/B6R5oo1EKAG5uP6YIPb3mU7iQaYeIH9w7Kzkk6QWnWKAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914915; c=relaxed/simple;
	bh=7C7JQQycmEDcWIaZ8Louq4ov1ZIdcV3cP85luqEzOzw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PFrV9NVUOP1aWRTqFel4cZgazmPRzwuHp8+UE1WX7ir5ffAt3iiT9OYaQXo5nA6iPg+yZbESNEqRspXItQdyOiXdHPhdw8B6PWx7XYzV6LANQuQhlRU/LgMTshPFJFxDZmOMql2MKo6OGxL/WKgfUSzT5EtcXXFlJ2kRq7Klw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqtvXQvu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqtvXQvu"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42c7bbf638bso19778511cf.2
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 04:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914913; x=1708519713; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRLquBBaD29YAwF9007KiO0RA41lLzXixqfGiQNICPA=;
        b=XqtvXQvuagoXxjteg01806pVnFZe0WwO6jBnsgFq8DQoXBxQhfKr85IIpBIvRroiWq
         vAUxEwaLV4QdObf+lMpmPVSDUeyIX7T9AQVcC7h/FGNZSYZoISlk5xeivW3ClJcKznv7
         yEieqdESsZSp/8Mp2wvVbBeUwVnU3RGS+I2zo3hKBbi5VhO3qYBySdd+2EZ5eiaDkxDA
         KB2+hdY5qy5n5zVwEhmI5Ka/nuPwl7jniNw00eOqCW11CHnx04ZhVl+rxw059SoM0n/H
         sNDpG40gOV+qn/PxQ3Zr3xi9Kg2zkYWU1uVyaxJBF+jPnL+8BmsPzwSYSZmr3R3MsN/w
         CXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914913; x=1708519713;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nRLquBBaD29YAwF9007KiO0RA41lLzXixqfGiQNICPA=;
        b=d123lax4aythfJ8GoJY03oR6W+SK+I/K771VeKfnyaTml5bFLpDR0rNSXwL3XbBU6I
         RTMoceri55SjegvydV5vsBfauRPJsqJ1wVPfU7/AkF5NZSHlgPq59UE/aO9vQ8zrKVCw
         e3YFBSKzesSH1s+5u+ZRWgTIBFW1SWR8ZukYfDXoOK0RbcgIKM+SZDqtxbFGXYUlW3ll
         N70QMDsPxICK4Uv0OiuhQ9ZvCfGBOHWC6UdCReFCbSwL9CmYEXzSoS1i2mztScFrxbaS
         V+jz1cRG4/LNqDvki6GoVaEYA8H9l0OKtI8hw5us/Dy/2RH7VHSLvO/znKRFl7lv/B3B
         FUlg==
X-Gm-Message-State: AOJu0YwdcdXgASAnj/jc+nuxROyIB9xHik6wuQHnuxtqrXlghqcOAtzN
	OFNzI6ucVIgF5Wp++5wGoCUTSykeyHk6Q7ESCg55lUAwR06thFAJMocYF6Y=
X-Google-Smtp-Source: AGHT+IEPsUwEnA+WiDtTUtXfAa/teOiYeAqc67w9MsqZd8PviZqZFvYZ97GdYqTxqFM1JD5z4amGNQ==
X-Received: by 2002:a0c:dc8e:0:b0:68c:af0f:c377 with SMTP id n14-20020a0cdc8e000000b0068caf0fc377mr2438144qvk.2.1707914912753;
        Wed, 14 Feb 2024 04:48:32 -0800 (PST)
Received: from [127.0.0.1] ([172.183.53.133])
        by smtp.gmail.com with ESMTPSA id ql18-20020a056214541200b0068f01e55bafsm485631qvb.145.2024.02.14.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:48:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b46824466aa1ede15dd8c8e0e5d6233b8b85ddfb.1707910454.git.tanggeliang@kylinos.cn>
References:
 <b46824466aa1ede15dd8c8e0e5d6233b8b85ddfb.1707910454.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <937f5aaf-7bd2-c197-fc82-88e2215ec927@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 12:48:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5161940717142016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5161940717142016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6287840623984640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6287840623984640/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ef0e97c755ed


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
