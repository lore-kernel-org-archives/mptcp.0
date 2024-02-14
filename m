Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AE181
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878166; cv=none; b=V7OLOR2iQu1GqaE/yZ1MAkZSxArFBLl5EImZZctvFI4Z5D21GHc/yJrRcl+HhBxUGjqhRJE0VoAO49VH5tnVCzlBlvcQTQNjbli6jyryCxSHBsOH8ipunJDSliS3Dcg6v/Qr3MkS3XIP1x46kaIu/SKfErJ8UO5WffyebHirfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878166; c=relaxed/simple;
	bh=p0iyo0/tJ+1tfJww51egTOlYYKWTAu4hWLnFXzI4MOM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XSajDTmHodHHfJ9ms2oUFlsLrCl8HlbhZkiu8WM2DZk+mITn4N4la8+lIN2BBm97YWm3sp1Onx8zYc0G+Capws2wuquRmMrJ7S7I8VkT7/upoKMUTrYy36529ilI2z4Ot7/RjIUO+h4uolU0ab7LGRbE4/U03V9grSufQjTgF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+adRr/b; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+adRr/b"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4c02478c8efso1162356e0c.0
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 18:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707878163; x=1708482963; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4G/EmRtU5pVbaOfQzjUc2TBKhOR5XBj/HzNFXtMlw4=;
        b=C+adRr/bFYmQwniutRA/qk3nRjN0wr4JqR7AKnOwbPS0uxHYgNHuE/hvSvmDdcat70
         y76Jj9wfgaf7c005+aNEr839+WsPy99Jz45Mj7MByy3CPgF30qbTy4ghk/zvU8slWIJN
         NYu9oQzTW9pVR7BLA6jmKR2qRQMelDVZTkt/U2ltKZrr58A/lf14jucE7SEFFw4V1Qnt
         9bRMo3h9D0KKIpwEkCuRrx8FMBV11yFf8XMGQ+O0Glw5OFVjAZSUCLitoDV8iPHJ3vMu
         LH61lFLKs+qaFjos9VfXl0OgLYCLZlxZ5agAxxbXkR+GXXCeDtWaMaFMtpPlvoUACLEc
         jqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707878163; x=1708482963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4G/EmRtU5pVbaOfQzjUc2TBKhOR5XBj/HzNFXtMlw4=;
        b=evaY4fse8nXGmFVsKEVPOgwn+DIyoJZ7nyMLoxyWXKLtdFOlZ830TfFjjGq0gh6aCo
         VEbBo99F5DUr4jy3N2POYRNC6q+qTMJMZ70JeRUmDzRyknZryXSxN4EWV6Ysm1dwtFfN
         id/U/1WDusqLdwpJxNEz57u79lghkXm1kRJnWZDCkeW+9clfTMjuOVEffUinQJXTDgj0
         mGvIQaCRfXR4vuP/f3cRM8q+A/cUsg9foZsT1PbOZkdVNgd1ZsevKvq3i76HYmLlegkw
         njSdZ3OAg73idaqE+1syGlXbpOEZsToWkncPBjuI1ly5by64EU+f/jjMWOXzAsajcPgs
         abOA==
X-Gm-Message-State: AOJu0YxyFX27yklfF+r/cPr48JZGRxmDcxCOJ8+xj7fYHTXtt01aJDTZ
	NE01DnawD7fSN56JmXzjrYnRpb2oPLli4zqOC0r5goLDNmzsFGvUOslZamgJ/w==
X-Google-Smtp-Source: AGHT+IEKnmVCkmOP1AKVbYFIle3uBULtFnSJU1q1LfP0huBEoNHcVWezVp8qBZovRuGN4N2rFOSExg==
X-Received: by 2002:a1f:c6c7:0:b0:4c0:3ea1:a4a0 with SMTP id w190-20020a1fc6c7000000b004c03ea1a4a0mr1159344vkf.16.1707878161814;
        Tue, 13 Feb 2024 18:36:01 -0800 (PST)
Received: from [127.0.0.1] ([20.55.221.246])
        by smtp.gmail.com with ESMTPSA id nw2-20020a0562143a0200b0068c89d8eb53sm1845023qvb.81.2024.02.13.18.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 18:36:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
References:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <c2a6606f-99de-f383-a239-0868a5644e32@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 02:36:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7895424329

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9b8ecb217a79


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
