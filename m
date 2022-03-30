Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79329A2
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 18:04:48 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id b189so17288578qkf.11
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=csMKqFgvpjT5rqSNOClvBqwXdI07yMeailBPLJLNM9o=;
        b=dLlgUcWLYimAknMJw+eDqK/bN8NNKTMViCJDCADnHCcvv54iXw2irSOOo6tqup9ruv
         Ohl4g3EuKD3RgtMw9RkuOKpdMQQnL7exLdBgKSmiS9qbf8mA0xInrN9RNClE3uR65Q81
         u4VYbu1DdRlAC4ChFEfUbReCkjknWSDu07kAf69xH+Dx0jHLPJFBD+oRMHn+KixgnbRV
         9gW4O0iwZDNRuXC/34Wn3T+D3pk7PeA1wb340efdqLWRA67fpe42d+nB9p2YjTBnPfca
         cU9nK8x7CTwnj45KRYlQpitwxTC8fUMxl/k/RERK1gu0VLuBeb5b8avcOuyEXWHFn1St
         04Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=csMKqFgvpjT5rqSNOClvBqwXdI07yMeailBPLJLNM9o=;
        b=nrKxosFrrKCeu/Vvo/9KBonDLjukBsZkjY9epwkcqeV2JP9ZX8Ypte6ddfiYLI798b
         U2YhIpuTJ1rE7Emd8B2GBiD7O/K7LKeeGqS/IBuoZCl9zrciEewnYUpDnQXOnw2QldV+
         4n1SM0l+t1A1dHzA0no+gLI4eocMM/mdtP6z7Nv2eUuuN3DPWeI+gPtQgl/a532KeFEx
         S+lHZO/o0Mm1CjsLrlY83esqrAMEV+gm15ctRN8e+0didghxbmCyt4mk4lzPOYU90Qx8
         7Ehu5A7nvYQsKj1YRet0mWh9duLEnZmEGu9FWoOXrbqfYXenR3FSVQyG3myrlIgCTYc2
         ndFg==
X-Gm-Message-State: AOAM530YBZgo6gwx1LoapTXsJpKqZxCdpUbyp2tegOU+sSFWpNaMh6Sr
	RXJxAqPDGnclhG1cHWobPQ==
X-Google-Smtp-Source: ABdhPJyRb7MzOvl7D/lfP3uQLkBsgb+7JYtuRznRDmVHNcudXdPQk/yoEegbNUiQTRjj7C5/LNIrhw==
X-Received: by 2002:a05:620a:2804:b0:67d:1e7b:b528 with SMTP id f4-20020a05620a280400b0067d1e7bb528mr665191qkp.193.1648663487147;
        Wed, 30 Mar 2022 11:04:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.204.34])
        by smtp.gmail.com with ESMTPSA id 78-20020a370551000000b0067e3a58c090sm11116982qkf.82.2022.03.30.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:04:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5ec49efb1dfd2777e779bf4362c6bbe67d89089c.1648537203.git.geliang.tang@suse.com>
References:
 <5ec49efb1dfd2777e779bf4362c6bbe67d89089c.1648537203.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <e668a3fd-13fa-f40f-7055-87ee2ab4a722@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 18:04:45 +0000
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
https://cirrus-ci.com/task/6543244744982528
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6543244744982528/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4713657396363264
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4713657396363264/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8b1e8ed0e57e

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
