Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C183A921
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 08:37:51 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-75ebd39fac8so55390285a.3
        for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686904671; x=1689496671;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxit80Q+o4PExIDyuzmp7qXrSEI3fF/JDkN1sddsMeM=;
        b=f9jw4A4bZ3rpSfvY4c6yYW8+SwUU5j0zkmNADmh1WFqiSskk7LIiMEL2Zv94h7o/H6
         7rJe5tgLhk2TdeBro4+IuQwAjJ2Q5k2NHmw5RUDNQ96OP+MqCZpjnyX4zJF6fsX4o3ok
         fkJYm/B8NjxHKzqIQSYObcsFKofHqhtnYALagfTfwrogqqpR9pwKIjQibwKx0KIErLfC
         irogLzLcri2oAUNehCLzZav7iz6DhX6KbKWh3cOMwIzP4jv1dj04KPn4egB/ZoprYDrU
         9AMZwvZ/kIGBXihc00XoYSVFQ6Y0yaVv/9rDJ98nDKVk+AmyuCT6sOqGk46KgGXhZypC
         Fuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904671; x=1689496671;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zxit80Q+o4PExIDyuzmp7qXrSEI3fF/JDkN1sddsMeM=;
        b=SV12+Yt8LjB6dgjKPbJM43+Ee561YedO29ERge65+i661KnqrKNvNs+J6jfIWdZbPR
         BktmCLAySsm3Ji0CwCC6vGAH9Mg/MpfnQHcsAtsyrkF/Bc2UVKfE/qBmxa0L6l0hcUHB
         QC6O7nyoq+MxfYxfnD8zcEFBdDkeQkTj0V6ls1QwNNdX4WPWnBeBHYShTfNy7ZwnpDoL
         RgoD7AEO/GS/IovmXoODYQ/xnqeeYwcmtSf49VyilIjq9GulqRhVPBnMfLPXRla0t/1K
         uo4rDRvtVROjXENCR26t6kJKCWj7q1dRgydDncFrzgPNurgu/6Qq9OUDt9Eqfhs7Jxys
         Qc3w==
X-Gm-Message-State: AC+VfDzuqUZmC+4vi04GiKJdsLYukSczZSr9xhZUJq6cfe3gx8yc6UQL
	gM6xGeulO5QXhOvlpcScjA==
X-Google-Smtp-Source: ACHHUZ70R7JY9glZQvPZcDlmyr5REOPDscG7TC7UA6FRF5quPJQPUM9emH6MhSr8HG8HVB3WN0CvMQ==
X-Received: by 2002:a05:620a:3e8b:b0:75d:5398:fc70 with SMTP id tv11-20020a05620a3e8b00b0075d5398fc70mr855674qkn.38.1686904670778;
        Fri, 16 Jun 2023 01:37:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.15.177])
        by smtp.gmail.com with ESMTPSA id p12-20020a05620a132c00b0075edaba7369sm6262481qkj.81.2023.06.16.01.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:37:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
References:
 <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: set endpoint out of transfer: Tests Results
Message-ID: <322cfbe9-7579-4167-5792-3cbcb9b10a87@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Jun 2023 08:37:49 +0000
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
com/task/4695769727369216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4695769727369216/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6384619587633152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6384619587633152/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5258719680790528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5258719680790528/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5821669634211840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5821669634211840/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0030d6af0c69


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
