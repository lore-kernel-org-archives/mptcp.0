Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1341A82
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKGhzF/1"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6707401e1edso34288486d6.1
        for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699977950; x=1700582750; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIQBMPetNAKnXrFYIMkLvF6uF94sorzqFTHKHJEj1xY=;
        b=DKGhzF/1nCodo22ZgNPIQfnzW0icAUHWKGrK/6nQ85hJqaQHBRxmYQgQJg0KMtAuNo
         nUH144hib0jbemdrFNfZs83MfNKoaBcxwufNEK0vJwWRY3ticIwcUbMOTp0bh55h5ED5
         yxygEG3I23czgYAeWAkVbXvtAtenQOT0dXi9cYRhmvwLDvWVxwYlEsEkyImuqKlnUXRn
         JQ5g/eCMFoAFA/3XanUm3f6od1HP+V+YckjdVscftIpP0vExziNV6c5G7T8q8i0UODW9
         SLDe8AqAp00nuOpRs1GA+n80mOSiMZbryFdhIBAQRNoo062riUE4/yQq9c7DNj134LYB
         edLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977950; x=1700582750;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZIQBMPetNAKnXrFYIMkLvF6uF94sorzqFTHKHJEj1xY=;
        b=HUbn/adcRKo94tbAAe+awhN079gYnF5ZdZiQgoc3axDNfdxtZLqbiqi16+6PU0z6PF
         DzFoe0awpd88i3dREC8KyJ8Ti5COPU+dwyf4XlCSB3sCCV3BoTnJuNulbqvsUSV8xZZm
         YZCCrn4ZPkzjvhXsgkSsCrZk4BaV4qQ2w0zulmbVZ44l9nSlao3Nc3npMtJfwXPrlPw7
         tVnHqNXnU7x+9DOv2q1k8QWrVH8S4zwAo7xw8Qk4LFCz6GdwW9VdoHOc3BPlXdstRlrp
         idWFaKXqSeAt7EKDg5ms8O5Bx04Tdh1ceTgjsnArTnuyh2QOqAf7LFUNtu/sVvSCRMIt
         rUHw==
X-Gm-Message-State: AOJu0Yw47OfehnREDdp8h55qYWWFEGgClQ1sYEuEUFkMQH+zLpBdMBPH
	lximeFfzwMqSFzz7kfqBWA==
X-Google-Smtp-Source: AGHT+IEIjSbpGiSjKcU6L73BjC1B5KyvdiHe80Pyf3xT+22T5CGOVDppi8Nsny3Im0jnqAkSmcwrDg==
X-Received: by 2002:a0c:ec81:0:b0:66d:bc21:814c with SMTP id u1-20020a0cec81000000b0066dbc21814cmr2508502qvo.65.1699977949752;
        Tue, 14 Nov 2023 08:05:49 -0800 (PST)
Received: from [127.0.0.1] ([20.51.206.96])
        by smtp.gmail.com with ESMTPSA id k12-20020a0cfd6c000000b0066d05ed3778sm3015485qvs.56.2023.11.14.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:49 -0800 (PST)
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
Message-ID: <781d9baf-ac94-4822-f85c-9852b2203ed2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2023 16:05:48 +0000
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
com/task/4901440322273280
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4901440322273280/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5464390275694592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5464390275694592/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6590290182537216
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6590290182537216/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6027340229115904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6027340229115904/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/553a2c18d727


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
