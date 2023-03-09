Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB233ED
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 09:39:52 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso706578ota.1
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678354792;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2n8MvucOKJthiAXf3m33Ln0R489w0nymjzIB1BPoiE=;
        b=NpeZs1jgsfo9jNaNAF44NqFJDySZpr7R2JULejHkSMeYff0Uf/XLRKrkGMJ26Lgu7V
         Yjg4AzwBng6zykR0nnx3gaz9rvnclWsResPbyTRJ6yO5Vm5jPHT8gIkVMc6Gw2TQ3rbl
         brjZMy75QnYIDm5AzIgvGP8TFTfBIQbAxMqm0jWu9FDjYudsYRqCWqdbPcY5tczu5cF8
         5fJw2wo/MEkRhKWunwITgvYrm/sctD4wQwy40edFlnn3YzKkHBBQADEuckT88RFDNmxC
         o5rxeOTe+pEihu+0Du9W6VSb0Hjnkmco8fkHUOe+EcQNviIoWHTxP9CMbi5dtq+VQvyp
         W2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354792;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2n8MvucOKJthiAXf3m33Ln0R489w0nymjzIB1BPoiE=;
        b=13CohbYh46ZsYkjK9c7tzaC0Uzc1r30g5ElbGFAeZUNOIqboprXt3ztXQlYeBNeOhh
         mp2rk3qDlyCg+aN/p4TRlAcTHp5Bref1SKk3GqCdzzVXue9Z2RMCv52MvDm1Py7aseOn
         rB+WKMqGxZpMv1iDGkt6bIs0Q7nY03ZDjZS7YjVp3xWJNvaz4Wt7V5janimfMhko+sIg
         CTlLGrTsHz9xAAwlW1HWpjbEIdRzYwHczeo41oE/6UBaz76XRsnCf6KJdpvxbENrf64C
         M+lC+8xJfKzkVZ7kEFhfmmOuANTTg5f/YacGRq/XvxkCCwd0ro/6iitcHG709HNz7lDr
         TXWg==
X-Gm-Message-State: AO0yUKVGN0P+yjkachAIEh7UVjjdyqMxIkQF0kc2KumrO/u4J6OF9Ci0
	YjQoX0BMulBPrEaGOg4Fmg==
X-Google-Smtp-Source: AK7set8NmSa4qGLKSkpE//rHNVRtH4mwxbU7nJnWs1qS0QcSMXu3Z8Gd0a3d5icREovXtkdSQn41VQ==
X-Received: by 2002:a05:6830:4393:b0:693:d92e:a8fa with SMTP id s19-20020a056830439300b00693d92ea8famr12375867otv.30.1678354792081;
        Thu, 09 Mar 2023 01:39:52 -0800 (PST)
Received: from [127.0.0.1] ([52.248.87.131])
        by smtp.gmail.com with ESMTPSA id q24-20020a05683031b800b0068bc48c61a5sm7384023ots.19.2023.03.09.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:39:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
References:
 <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_info tests: Tests Results
Message-ID: <cc37438c-5708-8ff0-35b3-594eec0f6799@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Mar 2023 09:39:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5242416765075456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5242416765075456/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6086841695207424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6086841695207424/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4960941788364800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4960941788364800/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6368316671918080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6368316671918080/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c0b6aa61c2a1


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
