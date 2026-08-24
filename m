Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1F339363
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561351; cv=none; b=jkweLltc4aKAvB+89cxJFsWFLlcRyK/X59nA0anhUEBfvYwBTX93k8JGavGi4jUD1OATIOUJSueu3rBzFxWk6KmVQH5j+e4sFgExSpDf6yGVouBwTpHKgmeiBRbx7nyOTpGHwiXotMJUkzS0loE0bMhtdQGwPlkeXn5nRTTluvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561351; c=relaxed/simple;
	bh=fRxcMtijkAD9fD0jS5yMh5EJrnkC2BiFvBENhiRTcXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IxNcUhL0idcTUVqRgyexiOd9ZjIt8cPOUeSWEs/K19G/nQuT1ybiy9ruDRBCHeBkocogwXVDLJw8gvg9fiqNHelCgTl2ShfyhHfFh/ak92gih4jyK/FdSgyRZSs3MZcIux7HhSoPz220BUno3wYh4zYBrp/P+nsPkx9+NJpnjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAc8Yib9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAc8Yib9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3539228a91.3
        for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787561349; x=1788166149; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kReUh3P6lbr9HO8iaDEoBrV6AkJyTonRZvrS6PQ/8Oo=;
        b=LAc8Yib9BNML+EH+bh2GUJ9X+lmbOFQnB53ZNfYOu5aMgIOy2/fdx7p5ROm0NpCKVk
         EA5YbyW53brRttC70tKLw8rw1I6HuVnVUkyHcDzmiQqLMjuqs234/mbWkLywIwU8G+5P
         aKzDEK5ByMqn7w+aJhynSvYBMJlnJ8bftW89ttBcE2SfwrA/jelBb2qnid7OB+kSmIDR
         MmCWo/cwhfqpNzxp3ZAqDxWXTro6mBNtG3CkTO+cFAFFb/ZdG3m6FakzzAaUgJnBphCh
         E9om9Nb524m18VFyVpfmWfsFdobE4qTMq1MDrV2u4wGnLE80fKJG3O1nuUoz9boNCWHX
         k9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561349; x=1788166149;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kReUh3P6lbr9HO8iaDEoBrV6AkJyTonRZvrS6PQ/8Oo=;
        b=odSJYEwEHu6UfkiGVWvrbrEL1IbOcXZKzZfupq/7iHJ9hcoglnxPYNEt1xYpzs68gv
         xLIRFkUfjtLZg6Br/qnaqJUgX6GuB8Fpy0xLMJ6yOFrxX6Q7J2XCYx0J652kSqyU6Xt8
         Hb7miCe9jYZdlmRze827DjWRCqqs6SjQ5WJhPF04rmlhyQt+ZByskYSqWKW/tnZkNpgT
         gJ1lg1ZsVPXTaJR5U0EccMV2Oy4xR7Vl+jaHJe26T0ZqG0V/K1bTKd8LeA5KYXznydHT
         vGlMcK6W89gCCtX7LFWLchJ4TfCdrt8vN3LvnNgG5yVIEACDJYXw155E+Nh43zQMtI7M
         RMpg==
X-Gm-Message-State: AFuF++kpzvnKg80MknCl2LG4AKou8mKA22ymV1KuXAeddg8M649t67sQ
	fll0BVH+cPItnfgOSscXAKAhXBnxRBzK44mnDGWKX/eo95CclSDT7nIan8YY
X-Gm-Gg: AR+sD13BZf+LkHJJ/FcU+5Vo+8DbU43OrJS/fZVv9Tvk+3df19konAC6qhz4bjz2iJJ
	Ui+E5VBcpMEAKAeJXJbJ64NZUwLlKBM9gPoQAq/MSpfWIPFLqlQ93K4Rw06HXqeXk5Lr9E78Uim
	DTrNT9NGqh7iwBlU3g202bY9apgRJ81tDnk/GPkL6eeWPBkQa5T1B2WhG8EetDT+PayQtQkr2an
	+uKwGaZCMcTbmQGhFGVty2TsuPEhfYitIvgPN9secPcDC2o5bxzBelcG8v15enNLmjXx5AWr/3n
	dK03Gq3msXXiTwZDCBiw6yBlbS0xHSE/qMPCEzwWpH/VKUj/b9GQhNF/tBPEQxxwZgUvCgQN2Gp
	cwLhbCJXdGNNeY+dcJwCT93IbAfO+KKUtXvq8nSEV0bF9BjUa7OlgyXThDFSQAzKfVoNJAnBn8m
	yc1hfGJwyG2Ye/6K/PsJOPjENnRDnpUGYksljmpXOxCKB1wE5P9G54kggkkUu0InwuqpZG3ChjW
	Q==
X-Received: by 2002:a17:90a:ec8e:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-395c2f2a10bmr44794519a91.0.1787561349066;
        Mon, 24 Aug 2026 01:49:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.125.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923f2c0sm36313782eec.30.2026.08.24.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:49:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260824073625.57471-1-gang.yan@linux.dev>
References: <20260824073625.57471-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v4 0/6] mptcp: avoid data-races around the
 sysctls
Message-ID: <6d623e9f-e350-d458-2b90-cef7b48560a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:49:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/327040=
90606

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/53301540be29
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1150683


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
