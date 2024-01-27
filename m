Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB8125A2
	for <mptcp@lists.linux.dev>; Sat, 27 Jan 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706325842; cv=none; b=IxnOf1AsXWkNXR2hLttx9SFwxuKO1veLB0g81EaUXc9Lqdvgq7ibv/8cfwnMRLe/IbwKm10fxaDREBHSAiKikUMeL57kRMvi1N2rjf+Y+dOpTeH9ef6eEMiQ4FzGvA0vw++5I8cqy3e6D6SYxDQh7aegTGjEH66vtt/Rg0PUO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706325842; c=relaxed/simple;
	bh=qYt9gKTyYndDsyQeY9QDmYioufn15LiQAOZZciSjBRs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XbScTjQkx2PloaDsLzBogJdW+dLRSoSTJuzmysD0/Q9lTrsyuTMNuvpTFYEZlFK2/5KEnzVIsVU+Yrak5lFGwNgrgt/mqXuKOjHYotxGdHk79ESelU4zBQA4QnZQXYS1l6UahTVBQJRIgCsrSNyWloQMhdIhIS4t4XRHvtj9qAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg4iHKmk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg4iHKmk"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a8a398cb2so2246071cf.1
        for <mptcp@lists.linux.dev>; Fri, 26 Jan 2024 19:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706325840; x=1706930640; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM8dghaesJGb8B54CEot9Sv2dGKs/So5xxUwtCUPtv4=;
        b=Vg4iHKmkCXick63xHh6QA+bS+25EsviGvsof5I6Wb7pWwgrV9GNIbOglIWm4J1YD0c
         RzQkgTgq/2Y/83ef/xCF14sCp3sQLBfxppjRUNAk3XiLRuq8qTlI0MgeT5VFS+oLWg0y
         ZggeQsq7mcr7xo5Q8WoDRTIDXUkbVK3wl+72i/lyxeOCEuegJId+zRYgvjnm28HDQlCN
         wycvvhV/Jrtuv2/oSWOjuyfn5vdYygyo25IAXt+P7xABlKtJU/AA6Jgd9FWzfcJutzoS
         Yhc1tky07XG6V3UwKhB/4dr3Wk4ci1eefajVD+2+FxEmXjVN8ZGoUPaSRxvbD0Qf+mIj
         IJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706325840; x=1706930640;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zM8dghaesJGb8B54CEot9Sv2dGKs/So5xxUwtCUPtv4=;
        b=GNk7AIZIjCH7f5hTEFWbZljH2fOTf63jcrrWOnajX3zew40v2TydnnZBh1EH8+5jmr
         oIURzRzjKss8r4lYdg1eN/LK+xa8IjprD0c+ITnZ+dY0O1hVHerAR/36tSr1RNSYG0B6
         RKoOotESHajo7mGuzHuvvYzEVlKUnSh12wEtyV1e8AHHYh0v7P7zkr12qmEe8yV+EDEm
         Pmf3EG5+WA9w3OCv4mV8rfmYxGV2NYwNCSL8pirKvWnWQbidMQPD5O6x0uvL530AdUvt
         PubXV9+vD2VbQbgSBkQV6XYDIrrAN/tA0JJpU1a8IvGYDZsbl6LzMQww0fWcPIYIXb28
         oYJw==
X-Gm-Message-State: AOJu0YzFODO3VgScCFcwGXBvS1yDHtFS8wrhtJlolRn06v7VhrYHbPyj
	z0rzQzAxeI3PjkTONmOv0dcndOyrHg30IREDNYZ37TkJV44eulo=
X-Google-Smtp-Source: AGHT+IFb4SicFZ0HBSZHQxli0KBY64Kxa5af1A1cF4Hlrf1nQHOXVJpOdOiCXvdynCkd1/eIbj49dw==
X-Received: by 2002:a05:622a:1e0a:b0:42a:5224:4ea3 with SMTP id br10-20020a05622a1e0a00b0042a52244ea3mr1102555qtb.57.1706325839839;
        Fri, 26 Jan 2024 19:23:59 -0800 (PST)
Received: from [127.0.0.1] ([40.79.247.226])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a110800b00783e08c89fdsm397572qkk.83.2024.01.26.19.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 19:23:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
References:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Subject: Re: mptcp: really cope with fastopen race.: Tests Results
Message-ID: <37d648f6-d04a-0937-9c96-728983195672@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jan 2024 03:23:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4896041841983488
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4896041841983488/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6021941748826112
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6021941748826112/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/00a670cc257a


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
