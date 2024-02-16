Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ADB53E24
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083084; cv=none; b=dUsWI5Ew7fJwAOtpD31OfiEVgv3d3H4WO2y4D1kKq0d8P216KZ0SGB5i0PEn4CP9ojp/ft7+4eL45DQRliCzaBHwzWpB0IHh7SpQIZ9WFPKV1MfUTU/yD1SXAE+Inu8fTGzF5X3vbAgbdWxlHSrqgDCH5IfnrIUEwUmjLzdPtT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083084; c=relaxed/simple;
	bh=gesqQwUHGapoBcwl82wsEvGVaktv8JuJ7OLwfLbeiMI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OYgqlf5v+OtcBFHoPSglvxgiJeZXsIn0YvGIZBr+yPaz7Ziu1AyEoYImppzDemBTcGqbnGS4LWZA5iQ9fJpdKOouW/hYIsgjxaUSMAfv8lUc3nHNTVG693+Fzb593u7cZTEj/wG6bgu1NPOuqZKVNjU91pD0D6r+cFXqS9h6RBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLy/azCg; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLy/azCg"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59927972125so1164011eaf.3
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708083081; x=1708687881; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSb2xWHVB+JH5pIF7/HcRY+UlLmderqCv8yDqqwl/Xw=;
        b=FLy/azCgS+pXgNXCtTeyynpm58JqHduu/UYjUCeu1sjLlafgu0OauSHPqzbp4o4AeO
         r1ugA6UH7d6XJ4N1qQAWC//R2lXNkmZb0tB7yuP+Q6FkB+8C3o1WBF6crzhstm9CVU5K
         m8gGYDzinZviCofjBaj0fxA7f3iOj84ePNj0h0ph1Z/h5E31rj8hxBqEpfArxx9WUe2M
         el5BKU7PuHuuAgLm3W7e1FGGofYdxHnGu8Ffu+KD9RrBS7SLuyd9fMvOR6XzMTCpE1Lm
         p1XlXZDnH84IsfhVFScycvTJwIXVm+90nYBkq98Yf5G+pdkSn28O054c/bTBcajrnqWN
         1vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083081; x=1708687881;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LSb2xWHVB+JH5pIF7/HcRY+UlLmderqCv8yDqqwl/Xw=;
        b=Ag035KQ9Q0xncsyEB22GdX0ziBXncubV6iDeqoLpy0KXba+etWDqLoW5Flls/OaHPi
         nBkBSqMur+vWdKB4TqVuDFZbVrAtV9qDnqpyR9y1P6XMhYY+g2msxteykbPmO1Eb8tHb
         IidnLFPBATssFx1rvZH2Fgu2fJ1TkVTYl1SOrxNuzoCNBPGAudWg+CCF1CcoJ9oneoOu
         Orz88OUC2ZOjD9lC+LNcImAbr6dNwzTcoD8ajVfxlj56Nlv+za9v81nG5hQi/af1B2j7
         JhZ1dYSVZ9W8hrW68cBNMuG9LsgEbbCiAVFl68edR+hlarqHYdfx2Sgo0g91vO9hfmQZ
         /18w==
X-Gm-Message-State: AOJu0YzYNOEd/+xOYsA19PHoYOBquLMJWVzYlwAu3jWGp1B2+fnjeYpH
	+/GDe8cOQxlmgOoDPog/7nuYrlh0PTIHGYCJG996hlHErG4KauMYOvB5ie0=
X-Google-Smtp-Source: AGHT+IGDDc+K58xo7cLFuKs6gddsAo7xSJki1F8y3e/Krcdiug/aN/dtYJgx8OJQrgNZAD9EdIJUpQ==
X-Received: by 2002:a05:6358:d12:b0:176:2bb2:12bb with SMTP id v18-20020a0563580d1200b001762bb212bbmr5059069rwj.1.1708083081071;
        Fri, 16 Feb 2024 03:31:21 -0800 (PST)
Received: from [127.0.0.1] ([20.51.198.245])
        by smtp.gmail.com with ESMTPSA id e15-20020ac84e4f000000b0042dce775a4bsm1370166qtw.3.2024.02.16.03.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:31:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
References:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <9f17203a-c2ea-3fd5-05b8-d83e10c272cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 11:31:20 +0000
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
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6499164826107904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6499164826107904/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4669577477488640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4669577477488640/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e8eb7a156396


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
