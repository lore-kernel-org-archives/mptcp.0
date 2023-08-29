Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F7156E9
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 16:43:54 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2684445a12.1
        for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693327434; x=1693932234;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFZSM8t397QI2BsnRvemEAZ/DZmm3lzjCEJn7E7muus=;
        b=K/G4vTYqKiOLeDHlFdTNjTrTS7EdDAcQUnLji/uvIHy9wKzHvpAGpm3caKVI8CrqYm
         7zrO0wlPMSct95LBGpjDJ/jzxUJmociR9F8OeEzK2sn/vjfYeIFasrenUctmOk0TpV+T
         zYRo3KyBGpMcdJd/EWDLt7UeYoz8Lun9E9O93bCLr+Gk5q0E0kEJwtoPJ5430LFd9buM
         6XucIgxsEJI7q84bkYs+jZDzvae/U0laG+UH5XdDM95eThy0tAEaMOm1CQl1HqG6ho52
         DCa0djJm0VQCuNQd4J6JlUQR1a5K0pEnShJR3A6L7AsLgNdZ7bckr8elPpjF2118DNFk
         tuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327434; x=1693932234;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFZSM8t397QI2BsnRvemEAZ/DZmm3lzjCEJn7E7muus=;
        b=N/qBQP0cUtJGPFSh0BQqSNULF8eu3jO88pIk9y1lTNhpgVTJTuPmhp0XcuPkXlKJTn
         wFwFpQdTAD+8g0cNvYRelHiF/8hBU/Zk857aqzgSew4ZkwTnQTUG02uUX9CBMB2aAobj
         w+DQUKg6sIWcTwrGHg0hWLISFxVUW24aQypuCVBrhkL21LnzxvRBeyRXJJOlpsuoFp9j
         lovJzCFtSEqzm4dXRjuVvNFB+0zcItMrsqpawunShdTEnGeFsDtXxrvW26DJJQimq7R2
         R3N2P2JvWNfpM4H+TfmRlFDtzxQqf2ZDwLEgZcfhPC0TebiDjFkUBivZ23cKON7I2/b/
         6Kzg==
X-Gm-Message-State: AOJu0YzypA82mBTY9ov3o71Te0N7tuDX4jK4pC7ICs4ZYf6qlg3prOwv
	EVA3wfjoIXcYb3ROKqFKGA==
X-Google-Smtp-Source: AGHT+IFY8xj+4YKlU8KAQZzLNhsfCaxmNwd7X+NET9Ufv5XZgguSbRYtjNbjz0rofBZjsOeE1+DJ7w==
X-Received: by 2002:a17:90a:760b:b0:26d:2bac:a0bb with SMTP id s11-20020a17090a760b00b0026d2baca0bbmr25158325pjk.6.1693327433578;
        Tue, 29 Aug 2023 09:43:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.116.105])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b0026b420ae167sm10804304pjl.17.2023.08.29.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 09:43:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <07268fba668d7645da445279581ecef9178c1b01.1693322440.git.pabeni@redhat.com>
References:
 <07268fba668d7645da445279581ecef9178c1b01.1693322440.git.pabeni@redhat.com>
Subject: Re: mptcp: implement connection level timeout.: Tests Results
Message-ID: <df187c8f-c21f-b403-9712-e9df3d0be783@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Aug 2023 16:43:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6536319392808960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6536319392808960/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4706732044189696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4706732044189696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5832631951032320
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5832631951032320/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5269681997611008
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5269681997611008/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4d10ef757a2a


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
Bot operated by Matthieu Baerts =
(Tessares)
