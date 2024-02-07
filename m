Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CB82D8F
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332989; cv=none; b=r+B+A+F964TpTGQI28yzkggh08bNg5ru3PDAv+uyMyZPHpG8s0mAwmGVZib/bvYnrWbyJd2+iwE8fh/1y+HObS+IrvqZVBYsg+QLLvMwBeri+Zchcg/49EtBAusLbQhZn97jG7K4GB7m4adSmFVeTDSuFQ9ep01m15NBs82fyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332989; c=relaxed/simple;
	bh=zMaRs7FTln+rAvvhOnQWMxteVp+e5GeogIJs37WEtu4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tNqvg8+Jw5GhrYXqt4quaTNc2WCoxBCZbRiWO1GvfoPwpUgWVO2ejvxfocDXsuleLoJA1sNeT0BjojHgfRp+0OHOLxpK0e+1uuMTUG2whCbdeY4l2dc4NEbikbrI6BJ01uTat0c/cWN/4usyxmnQBwCAfnaCk078B6wnQ+E5Leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhjXTGpS; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhjXTGpS"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68cbff3bd92so3776886d6.3
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 11:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707332987; x=1707937787; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajZApzk58QQT9zfvE+oPWnGMjD9D8SxdKE0mB8vgrc0=;
        b=BhjXTGpS+NspfvYuTJpXKmG/3wX/+61kUc5c1q6G7DpXzDXZMyvvCiIciCv4yHvSXN
         f67JO7mbhmY4Gz5GzD/FA423Ae8AeCEutac6tfR5MEbifcDAgK97sG13gHuSfSVNVp9Y
         55UYr/KHTnj0Itr450ELP9aOU+dGXLNBU0DRLdCSwz5GQtn33zwWiwQA+dGWkpwN0DjI
         7Y8H3IP+O8Dt7/9Pp1uOMvqk/NzC0dl2zjn/JRramKQrywzEsxmabvoJibtRfgVPwENY
         b65M+31hYTIWmq12GX+BoXxnPv/cO97lahW7nIQXGH+bPs2LO34PxBFKqgBeBGii1Srt
         pQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332987; x=1707937787;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajZApzk58QQT9zfvE+oPWnGMjD9D8SxdKE0mB8vgrc0=;
        b=uydpNQDH9KK/5C0J+NXtA1/IOJRF/5JCT5Gx8yR+hfgW2XGyBBvaDHmT9DmHHV7FER
         ZYn5Ee1s4oZic7DlRBxJ5okoy4BapXfr6joDPEHrR7eAYNreSVR97EAibkYimX/ZwuEc
         OxCJjH8mASXZxnYEc6IZshyn6Ch/PSJ3UOmTn/XqI0xW6+CRzN93sZ064xx0jsLnvoKI
         Co7rJY9lGIvcQ9n5rY28PXsMg+JGS1sWWi5HKQNpp8aqHd+kP5YAX9GvWc8HCf/lwJnn
         EaOFxzUeKWC2jEKTKkIfHJkPmVDvrkjcY0ysGMGQmdEITNuUHO6ZGJRvEfnsY5ekQOJa
         C/lw==
X-Gm-Message-State: AOJu0YxHF+Igoo+Yc0xQ2CWnRPOrLsn7rPmGEkBOEoRBQaj9Nf1W2Do1
	xzxe4yIMp5s2jquumtn4VCROntUIxC8azL91GMQQbIkBtfnYwepgSeGMsho=
X-Google-Smtp-Source: AGHT+IGWjGT/3RST2/5FaAwPAocw/iKA+x4LmfA67mF/2tGuqm+SgxYLcpSNCMIDQZZufnD9DJz2UQ==
X-Received: by 2002:a05:6214:3f81:b0:68c:7f0e:abf9 with SMTP id ow1-20020a0562143f8100b0068c7f0eabf9mr7865900qvb.42.1707332987226;
        Wed, 07 Feb 2024 11:09:47 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.70])
        by smtp.gmail.com with ESMTPSA id op5-20020a056214458500b0068cb0453881sm855433qvb.96.2024.02.07.11.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:09:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
References:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
Subject: Re: selftests: mptcp: stop forcing iptables-legacy: Tests Results
Message-ID: <0952b887-680b-95b2-5576-1cd8bd783b35@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 19:09:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7819512363

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4f8d1ad0ee1a


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
