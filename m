Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6D1C31
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 12:39:20 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id r66so13087662pgr.2
        for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/LJ6d+Fyc8WKxUjHytU29mh0j/+knCueMPmh4BspBzA=;
        b=RTPt8u9pU/tGylR69tUAOv5LaPK9kO0AE34He9cGHRq6HkKqQaJXfHSKP0RpS1UPRa
         /P6BI9lUgTv/iUJX8YSkJ/RNu8/RpM08vuiNl+3e4pvQxIPDLy+4B3rNG1/wE7PzLOCS
         skn2RBo2rU44os9aJk7l2xnYpDir+QEMY9O6S6QWOgBuZobApk2fihOvd4JgoMcb7ovq
         SVUnl/syTtqH4U6Hbx7gkdj2bmmWv7S8KBnzmzeAfuS9kFWYSX8OAxbhrultSvaoqZQ9
         1LPlH9hOcxTLpGmky74uj6E2ya2iRz1cICanID1YTKhl7G5lm8WLOcXgIqeM8L0NwMmv
         vXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/LJ6d+Fyc8WKxUjHytU29mh0j/+knCueMPmh4BspBzA=;
        b=DpU2poR9QgbVKiToHuJrCKu2sYw8bVNBdUI6ReYy+wIj0t1fEwxi41loEvZHktDkPW
         q5cLYRuNvjBxOq9U4hfKxmAJhHTt6deAVEYRefiP6FYii0AA28cC4Rsct1SrrEhYshWw
         ibz6xA35bSIsjFW+rYxJjfpUyjPeH21c4v9DzWyiJLtZMGA1xkFUCF61IrRTvc1L/PkN
         wp3EerkXAUhUy3aa0SBFApCp1pnZA7jOrTKQnmx95ER11wW55OSw4I7YU6VkyaJuNeGT
         NzoxA4jn7fbDpI6S+QCXW121tkIyw35LQyXdluVbDKoYPsZPWRVZVT+m8T3bpTWIDewc
         aKWw==
X-Gm-Message-State: AJIora+0ZTR8nwTZhK47ZAHJp2/dWcMRFNQC2/+vu5Fa089wWl9lNBRV
	rtfV7AtSdyM0MQ6FA1gl9w==
X-Google-Smtp-Source: AGRyM1sKy3tQvStT/p9tTO/xnOxlQQyjtv/pm0FOXvI5y7K5etBOogLku264Sg13d+L/Lj0w2+0NHQ==
X-Received: by 2002:aa7:8889:0:b0:51c:41b6:6e2e with SMTP id z9-20020aa78889000000b0051c41b66e2emr40883229pfe.46.1655987959811;
        Thu, 23 Jun 2022 05:39:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.172.204])
        by smtp.gmail.com with ESMTPSA id m24-20020a637118000000b0040cff9def93sm5223053pgc.66.2022.06.23.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 05:39:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e721cb6af6bec51ce7aa90d5f45d432c85222d93.1655979747.git.geliang.tang@suse.com>
References:
 <e721cb6af6bec51ce7aa90d5f45d432c85222d93.1655979747.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <987ae756-7796-81cd-a755-d58490a9c344@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jun 2022 12:39:18 +0000
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
  - Unstable: 3 failed test(s): =
mptcp_connect_mmap selftest_mptcp_connect selftest_simult_flows - Critical:=
 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6077066394206208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6077066394206208/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
selftest_mptcp_connect selftest_mptcp_join selftest_simult_flows - =
Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5514116440784896
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5514116440784896/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/450c64653a9a


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
