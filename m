Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638C3A264
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533504; cv=none; b=ehd3D62yduIj0nULfM5VoNuGpjfQo44KWLowouaBsPMcJjrPntU32QfgaLCldpotFIlXjuTiU921pgE73KpvnT9i+M3moIITU37UjfLPfGx+T9c0MTk4jlHvaaqTUx1FLsHOANbFbhdwd5BO96tFHnJYbUkjss0+XNvRTsMIwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533504; c=relaxed/simple;
	bh=RQ9aT7+qYM2qAztTC8/PAz9sjS2s+Uv+uUoyi/wSMVA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R1mB8AIVf8ZLY84+E8LkCXZ1gsGCGgSfXwjoE7gvZkcyS1zmv8hg68o3BqlSnT7ir60ccSMG+ImSXz/TybqpGI/nPn88PDNifV4TOToyHDf4MrEojMV5WzlvofeSN+OEV2PnY0sCfsuwLCJz5/yYEGzUdTtTMQFt7M+Pk3MZ6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE5zJWWm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE5zJWWm"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430a65e973bso41022651cf.3
        for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533502; x=1712138302; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oIQBvD/9Abq/oB/+h/1U15sV4cYGs38U0piuYOSnCU=;
        b=kE5zJWWmLTNvVUoY1g1Pj2JdLGt4udoAddnD0hFjrJxu70OEqr8Inc4f6C7SghWPqU
         ZQDFUTiIxvUzqf2x1k4Bsk8Rxo3ek8aEGO6m54g+gcWm+y+ptCiIt/tMC/bYqH8KqfMW
         AlSBM4RpptpSj7narCFB7afw6/XMJWOOouphpQc1LA/1L6UFCW46wppQyNHYgI6ke+ym
         dxmfb2ZAyCfnwBilrRTwGgIWE4jppqQJxVtEqVkyb/ukoBziB2w1+3OWUcvBAnyLVeiL
         IpIrqTtJpe9UUSW8TDac1/86iqPcyUFx/HD2Bm5JTA5eScxwaDMTak2vM3O8qTzZ00J6
         PA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533502; x=1712138302;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oIQBvD/9Abq/oB/+h/1U15sV4cYGs38U0piuYOSnCU=;
        b=izlAnd/6jOkslj4xi/jYJAPIyfaPEJC3gPt4lEeR0ap3luXP0BClmkm3Qup9/y1xfh
         NX+BMp+hKh8pYsOlUDvG2Bmh21eVWSysHe8H+6BMe1apNrPNUyR35PPvGSjjJ0ykwp/8
         FKQ5IwsQTBr3264KGhJmNw/R4KKO1egXgd/Nm3eLWN2eCZj2q4XHjkX4WCTZ5wywjIki
         KYrQfVR0TAqPhFAlgLXtbQPEmolXyp5/xEXVCQX8J+jkR8aPuOYmebA67fBC34UrD79J
         3IsWOHZ3a8nEFAQQW44qhUtmT5saU9PC30CNeszNNaUi/IqNciUbcXrKzd2JyIJ9bBHz
         aEZw==
X-Gm-Message-State: AOJu0YwatE8ZUUWj2FR5Ctknb0AZSBtGSxJU9zhuYXXdx7CxwIBouV2l
	MlIrIAsXUXi5BBp3EUq4kUkxlBKpK+heRIPrZmDrG+f9ERrlJV2KqMFDL98=
X-Google-Smtp-Source: AGHT+IG7AbUM3s8e2oOa4hByg17GvIvGe6iUeJcp3LbZ2b7Yn3JRi2ABDjrasl9JUOKbI3Jruu6trw==
X-Received: by 2002:a05:622a:613:b0:42e:f8ff:b820 with SMTP id z19-20020a05622a061300b0042ef8ffb820mr601278qta.67.1711533501598;
        Wed, 27 Mar 2024 02:58:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.133])
        by smtp.gmail.com with ESMTPSA id eh15-20020a05622a578f00b004309cd26bedsm4636993qtb.72.2024.03.27.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:58:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 00/11] setsockopt per subflow: BPF
Message-ID: <d0fd0bcf-3f4b-90c3-8abc-7d7e194cd841@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2024 09:58:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8449427104

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8654a5f8d6bc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D838784


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
