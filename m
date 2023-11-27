Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E23DB84
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYyY6myv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso32788055ad.0
        for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701110434; x=1701715234; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UMcrGWg0LpIZZrOMLwyop84gvxR53fbDCo2WJdDT1Q=;
        b=HYyY6myvLhGR+bZgr8fIONufO8hHDkZBSG9B0RqGchLvVlqld51GvGNzK5uzkKwFWg
         q+atzNoGB8EwLkoFdUhyZ0iQb/+uIdriW5YwcRMVpHcz4gp6YIjmxBjZ4sgq+G6ItCdp
         gOJidblUYDSIVU60m13FFfhzr0B3gwa34Fs9d72gZBWujzfkRMClL6qybNQZ4HbtGIgE
         6TDilhJizrFDcX5uWZykSc5vh5anTG3SPBk7HhhblLy+5qNXJ3MOpr9tzuHsVpMIvXj7
         FrgaI1cIIO/yLiRESJJTKbYsrXqZY1gItuQzZ+by2PFzXG158auvK3eUyECpay7K7cvS
         H0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701110434; x=1701715234;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4UMcrGWg0LpIZZrOMLwyop84gvxR53fbDCo2WJdDT1Q=;
        b=SJSJYH7gFwByooOxnzWdwG7sEByZ5BS/GitK7IJlfEdEY7WdTxjZo1jFUPthIP2DMW
         lyQGhoipArFYWoCtKMMoCFNnrWF7xKxPWn1PC60nBX7B6L05zJ9dDMhQPim0O6epYbgk
         Incw8lzXmsjsfvm+r0cbqkrCfeEEC44FtgmXWL5scX1jSJjeTtLFTPdqkZg0HulFzhIW
         Nt5uzVK0B3PoqdAADW+j7/wXmB3rmKjTrSv3KqGN0mMu81+64yo0hi93GSFXQG7MjQOe
         or23vdkCJkzn18jbdKmt+wSzhoKEHfXVlPdlSKuabRS8PTzbTqBo7CgOlM8rY6ebbhRj
         SXXA==
X-Gm-Message-State: AOJu0YymVrueDYMbmVMxIK2a4iuvzrAILm2eFgqpMEPLURi1zF+7cCJo
	WkoANiEROiMj1zTqaPb0o4c3Fj/HcA==
X-Google-Smtp-Source: AGHT+IFnq+PaFPp9Lc+mZDRSPkoNvJ7tsy0VpcFZTxSBtrGO58thQUbXVa9D/F52pDmqrkoQnkV4RA==
X-Received: by 2002:a17:902:cecf:b0:1cf:a105:6a0b with SMTP id d15-20020a170902cecf00b001cfa1056a0bmr13409873plg.62.1701110434341;
        Mon, 27 Nov 2023 10:40:34 -0800 (PST)
Received: from [127.0.0.1] ([52.225.76.179])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001c9db5e2929sm7208301plq.93.2023.11.27.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:40:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
References:
 <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: fix subflow_send_ack lookup: Tests
 Results
Message-ID: <69c0313f-d449-6113-385f-0317fb6dbbfb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Nov 2023 18:40:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6254656741965824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6254656741965824/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4847281858412544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4847281858412544/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5973181765255168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5973181765255168/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5410231811833856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5410231811833856/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1caf9ca259e7


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
