Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9548BE
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 11:56:12 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso2008676pjb.1
        for <mptcp@lists.linux.dev>; Tue, 08 Mar 2022 03:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=AUXkwNLyQxFEFw9mvcsmdSpm+/VCJJ57WF5VQZsENxo=;
        b=NNzjArXPiqZVSiK1sYq/m04FGPOiLwGmlZEfR6B4EEigk0NHSMromNOoDlmBPtVxlv
         2mVvS6oxr1UPZK7KT7mwBNgjIawOv5wp+3bhSogkhlPHSzxlxxki6b6hVXj2tuCj9d+2
         ifbKuI91QNuW+XzXx+l+waJg/qMharozaj1gEGGkVUHBe6RxxKCC1bNs8UTWQ+RHAZmX
         Xj3cyKjkQmBexddVYbpNhY2uY4glamK7HaCxK42F27rW1erxWBN9W7/Sz3mPaok4CquK
         e8ZO1AevXeNEkU92GhgjgBEsmrnbUSxiJbY6fV4AyVws8HdWpbqQNBNg+30zCEVFfnqa
         3k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=AUXkwNLyQxFEFw9mvcsmdSpm+/VCJJ57WF5VQZsENxo=;
        b=oO/ybYuAMcaxonlKZpzXIc5FwBczWNkF+s7hNicMROAU8aUeRkeQzYTtyO7MIY5lO9
         439YNMZNe8DhxZ68+VYGQc93mQSZwtAPzLZE9nLzDq6FwIJd4GtwzCtK0gp1WefsWVzA
         Znr3hM752D9Reh2XNDtERFTzWTryR1NUQv9gNHc3xQ9ICz/kEDSECG6Engq6uj+o2qSx
         OYZcGKiowijdEJbHjV9eLq50PJYUzwQTlLJkDUQs4lg0MWCWGGc4nTZPG5FtkUMUjCx4
         oI2QZahwKknbeKoSO4nHURKKuMI60hoPljtAGi0DLsnHdbEdeizBGa0yj24rihIqywOm
         qJWw==
X-Gm-Message-State: AOAM5300VWAwMR4ww4ZHnRUvrZ8YGMQUiXlRjm2zy3dFz5bi7ALJR1ol
	kWnWTrZqJlKantTEsc33+Q==
X-Google-Smtp-Source: ABdhPJxlBe/j6IjBc5s2FJuYfgOrMTSU5zKNKROE5Za6zoyAx1yClDKdE1CwAyGagGTKd+qqig4blw==
X-Received: by 2002:a17:902:e848:b0:151:e3a5:b609 with SMTP id t8-20020a170902e84800b00151e3a5b609mr11293411plg.137.1646740572063;
        Tue, 08 Mar 2022 03:56:12 -0800 (PST)
Received: from [127.0.0.1] ([104.40.78.67])
        by smtp.gmail.com with ESMTPSA id f6-20020a654006000000b00346193b405fsm14793583pgp.44.2022.03.08.03.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:56:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9241878dc92e1768e5fdf917049a27fb2898b8fd.1646736285.git.geliang.tang@suse.com>
References:
 <9241878dc92e1768e5fdf917049a27fb2898b8fd.1646736285.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add skc_to_mptcp_sock test: Tests Results
Message-ID: <44ab40fb-2550-486d-ab2c-f017b2c42f4a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Mar 2022 11:56:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4983207497039872
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4983207497039872/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6109107403882496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6109107403882496/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/55691758245d

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
