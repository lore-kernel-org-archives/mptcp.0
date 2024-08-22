Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B214F9DA
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322081; cv=none; b=SIMKdRJzr4OZ2rgIb+fKTSqBKP2AAAVpRtxmQ5rU3e7tWKWRShtBRFSwD8F7v9LErXdJG+VRnCOwa12AjJpAPKrsGIftjmpJ5dYKtgrLsknQFtuBbwB2DJlTQedCxGd2+6j4RWfMbdawuePDElSJrncyLQvluzciAekOtOdWrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322081; c=relaxed/simple;
	bh=mYXU3huh4rwuzkHeFjLlPfBPa5BmZkGTJfXXMmXWAVs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cvdiu18twy/vyJQ88BzugiaqL95oWUEKD7hCkKfXWBDEmiMAXec4eLSksin5n1nPUe1LDLUqi6RrgPt6LgOSTEBeWSgt1oLIz7egvii5R8bJ+NXNchdSHV5aqcOz2ASOl5x5bAz/jFy3PnkBx4eM43cR2IsZ2pjKFeIQ7BrX1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cREXqS+5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cREXqS+5"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1dea79e1aso40056985a.1
        for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724322079; x=1724926879; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzqO0do0bfAuft5tK+5kqWXK6tvLkIULh9ijfbHZzVM=;
        b=cREXqS+5NriamRW95hkWAh6T3JbWKf26AC+sX3IYNH03h0+mA2G79lEDdyJfgaXsac
         BHJvt+/1XS9ooLmMKUyNN0GJB2QulareDkrKH5hQ9HWICvIouU9bgeyl0UJmqJD2AoRz
         LhIroJCTCjBYBsdGTfAb0WCmzleil+9BQnRHp5U/0w/oHvuVt03h8WRzcC24rSg8DD1O
         fRGVdIjFJ4NPeiBkUzlLweCrFVwA9Jufk6W7oDHMTAIsfPytnSTZd7dR0rSH4/rcGlxt
         cl98CGqFhTn0BlDNZjrRNxWbtTzwIXnJ+axQ4h7bjOuIJe31pdaHrmNfuznY8In/4EQm
         Mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322079; x=1724926879;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VzqO0do0bfAuft5tK+5kqWXK6tvLkIULh9ijfbHZzVM=;
        b=ljyTD02lWahEWcXqp8Ua+RBR7D6z8BeJZg8aGAh2PAo4WD0O+5ifQN4WLjd1tFhWwy
         /yxjuTolHbL2FCZncr+0pIDXPOFhDRAk/2x9UlitkGTG2P8omg4OU3SbCiVYnqyckPVa
         hnWJLq5EchYbn/VHxP1cZ48we8YEKq16aeR/SYst11xCI3TssMuKEjm2OOtzHllnwXbp
         KEInELo6z1tn+lQXSQcjiuqRjb3li2sCpWdxSbGRYkQgkvQf7RgggXWImxgInt6kUOXR
         Tcwd6B1wa8xupFnOW01P7jXXKUqcK0Ew4J/oqM3KfMUWYdwHMwg6yIP/MaD0B8wiMemb
         PfQA==
X-Gm-Message-State: AOJu0YzmUGTzAbO8djqBgJsL3QLRNAsVUV9OgK75BcLisChs9stnzLAU
	8pp6/yN/Qxk7IX5SRosR00VuXJRJPY2SJufh8/kq0AsylKMkneujJait
X-Google-Smtp-Source: AGHT+IFbD6tuvDBykQlYGdx+ENTYVIfch6PHelCPTPLIwL95PRhHSFcPTA5maqjc1xOz+Kuhsb5TaA==
X-Received: by 2002:a05:620a:25d0:b0:7a1:dff1:57ab with SMTP id af79cd13be357-7a6748f554cmr454388685a.23.1724322078865;
        Thu, 22 Aug 2024 03:21:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.108.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb523sm53125485a.95.2024.08.22.03.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:21:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1724318341.git.tanggeliang@kylinos.cn>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/2=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <6be00625-5c99-4fad-a504-39d889a7a626@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Aug 2024 10:21:17 +0000
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
Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/105057=
02786

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4dd5dad52fbd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D882086


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
