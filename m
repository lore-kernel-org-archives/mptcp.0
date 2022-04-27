Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D567E
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 03:30:50 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id y38so502680pfa.6
        for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 20:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=0ToLhpjgzGc6VMkJJiBe1n/BHjvr/uPJjLS6fGkwC/0=;
        b=nA8nlaDAFolU9kofgP8y4/FOnHRNf6MYwM4LTt4xdA/EPav5c1ma+5fWsfi2XAr9jP
         99eGq49OPYIDYVTtY8mIQOqmKYqWV2ELnkQIXcV3rgxesyvVWrW6MUNltk5xttpsy+lp
         DFQIKRwFxtE+FwU7zMen/hPgvF+ySVENRyfp9anELGJXdjcN8LdXIGYWl3WP4cJ7nLIj
         pN33ZYs1S5egFKFYqVrkDV5Rmyexfou56HjQILhE19MQVvH2Zu2EuEwCot514NKGuO99
         ZgnVmRQPHUsDQ/A7jpNJQhGZh6OeIm12vAmmwq5zXVI5m83pT8pa3yay9UNxOzOkmQzO
         2Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=0ToLhpjgzGc6VMkJJiBe1n/BHjvr/uPJjLS6fGkwC/0=;
        b=qQgQjuFbLKDa2t+wmWfFfV1AZ67Tba20+47Dkih0R3BftnWqQjwMFj1/ep69F7lGyl
         V/4W6fRS8T3ImnDk+55n6+e1mMZGXfkZVfesHEGO6PH2yvdMYJ7jvvyHmriFXbbkYuFc
         CG8IU1om587m3e/ylLrhqg+RTw9vllL42qb6Af/8FoVVm87wRix09U7pU7AJpeSF0GM0
         XqFDyLI13CKPzwLFtNfTVA3myJV9+tX/1u41TPCkwqK5+8F3sLSA/DDx190WDOTx7klg
         7Pj7jpsUKEhMBbvBvPDlRE1CoU56SogxoRXaEV514Mj3BhUM8C7ZeOg10tDnBZJp+mSs
         cgTg==
X-Gm-Message-State: AOAM531Gl02uPa9+s6UTdQ5VvV4QLC0EG46DY+oj7H2QOWNqcG7o7+J9
	bT4VrnzOixiyu/+hc1T8dw==
X-Google-Smtp-Source: ABdhPJxuVl1YdFe5VW1AzcAlWKeAOxyIReHiKNlvTS0fgWMlC8Jf81veyZmyACK0Ms7Ctl9spbhnIQ==
X-Received: by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id j18-20020a056a00131200b004e158c4ddfdmr27623953pfu.65.1651030250469;
        Tue, 26 Apr 2022 20:30:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.242.82])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004cdccd3da08sm18093127pfl.44.2022.04.26.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 20:30:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1cdd5e7c527dbddf865de4242bdede522a33102a.1651024344.git.geliang.tang@suse.com>
References:
 <1cdd5e7c527dbddf865de4242bdede522a33102a.1651024344.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <40d6c42f-eb8a-7270-c002-f3f08f9598f2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Apr 2022 03:30:49 +0000
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
https://cirrus-ci.com/task/5378906021691392
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5378906021691392/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6504805928534016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6504805928534016/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ffe30335bc16


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
Bot operated by Matthieu Baerts (Tessares)
