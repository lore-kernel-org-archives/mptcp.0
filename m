Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2B1A0BEF
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140011; cv=none; b=Cfpm/ywUsRSh+uuGkzuvSUAzOk2mSLUI3qvy+IpxY4K4wrEFOE+RS5vde6OfpkA+1YPo+PCsO+P+/j193xALRRhp5oDWA0Sfh2b8rgcb7VBcowretRlPkUmuPTtDczInWDv2v/6SDtao8fYPN/i8tUyX3wqU5Hp8a1fP/g0Z/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140011; c=relaxed/simple;
	bh=o5UXV7b8Wz7TEHtwAiJZLOMQ5/iw0lA03Y3kgueTQ4E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DYtHEecwV/9bY0nDrDPAz/YFE60XF+KxGVdzRP8bGtb7Uu1QgbLVxBECwz/WeqjM1r3n9rzzI0DKh/zoVSeuMeH/9ydKYY71eCQz6JytpleVm/rsQ/6XisGWCjMjzW97xN0orNZ9XfTtIeqvenZkZ/PvAs0yBGKmS07f4FGMZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDSn/Fwp; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDSn/Fwp"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso6594076d6.0
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726140009; x=1726744809; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev8kj7dBgVCsj55xFaR0ybW5/l0EFqKAfhNfxtTW+m4=;
        b=UDSn/FwpSPrFTy1eOAXUk4cRgGnH+9lXa6nkL0p+dVrlJprE3cRZVOg7EIc0HylZUK
         7ocnMFMu+bAXQAYnKF2QHGkQRNJLUsyaQOqza2i7yYEjLES3+mq5xegwBv4ESvreuYyH
         iVzonyCdGIHFK2hDSGBKsH/E3n/N5j6uLUU2YFn8LUS+DybTiPV7Qfll2gpQPurhXUZp
         2I7cbSU5SYs84KY/C20nHGhTOgtA+IjEAPThJm42jONEB0oU5FibhZYKTWjCosOkAiNG
         6YCGsmW175ofSi/nPJvcoCZrLtiI3DvqyubuOLk5f8nOr+kC7ecXQFb/KWt5OZTEw8sL
         S12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726140009; x=1726744809;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ev8kj7dBgVCsj55xFaR0ybW5/l0EFqKAfhNfxtTW+m4=;
        b=G9BvHopuxu7XBk4ElF5/Er/xf1kaBQxTbNqvwpOZfOcknsTireThXuFZJJoNGXcnFM
         nlNyZs6i0wgvnPkzpubX6BEUgTIv3vITJCb4U5bOwZJY/tr7dONI/dE7JqIQFfm1d0vO
         /VuCPcWx62gFvCn5r/DuqGI3nTErHuEJQQ3QpZB8v/PnC7numn5oWDlnG6GILfIYevpO
         qJlwxs/k3qtWt07GFybD13C+1sZKDYPDARHWpIqDiscrnHRU3+E3z1XS6KstAiEFIhIK
         bZZMvB6otY/Q1iY/uvTBw5rG0wheaciaC3aNysAr5MHUXAdfhXoohu5iwtSEQTpRthxP
         bL9A==
X-Gm-Message-State: AOJu0Yyw64i3XDpJ7PNL/ifipYftB4XZALaY0Df5OV+6ivhHybKwZ2Sn
	neNhKtIvaxZCvJIynQN1igvElcsFHo75DIN3kHVbPmfwIiitBUc=
X-Google-Smtp-Source: AGHT+IEXhG1moGvU0NnoaSoP5UHeFFjd/aZ63gq8G+Xewdyl45Bme4RnSpfF/D86sZTuEUBFjvgVKA==
X-Received: by 2002:a05:6214:5f0e:b0:6c5:688a:63c4 with SMTP id 6a1803df08f44-6c573592a86mr27935506d6.51.1726140008676;
        Thu, 12 Sep 2024 04:20:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.115.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433c29asm52837776d6.38.2024.09.12.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:20:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
References:
 <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
Subject: Re: [PATCH net-next] memory-provider: fix compilation issue
 without SYSFS
Message-ID: <02a4de21-e8ec-85ed-853c-fb4befca7bb9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 11:20:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10829149648

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b906440906a3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889709


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
