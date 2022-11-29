Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE0AD4B
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 18:13:41 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id x18so10421668qki.4
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F1Gl5jRwki3EQqNvQKiwJhi1VXiZUxnobQV5bxPofY=;
        b=GL5tTqya73J/i88LLJ795LcyH7HAkoUhheniowAnPX9Azq0a2AaTzbyyTgRDqT+NkO
         70XS9WujG6/9d/1LFgNrPX2TxaCu6LEgny4MQlsFyUxF5rsbw4bO7PzejK4Al8xI4aq2
         TspP4vSYLCzfQ9yEVgoySmIlH8qsQHGgZx6w26mIMIWutaC6NJfvKaAaz8xwOjnxWcw+
         imtLK71TEaKm+stREmqKwTIbfVna9pcR7n7GAo7adkBvcMQDwNC11MAFExSySetk4HbU
         lPWmUVziJTqJ+NnUdXVaXXSYPLsNN5aHiaoOvhmw7WTEbeA4uC6x7re/2qQ9oK76oOyw
         u9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1F1Gl5jRwki3EQqNvQKiwJhi1VXiZUxnobQV5bxPofY=;
        b=xxIjKW+/SiXdhd/27FoG1N3hHeD38pGYYjP0lxAJVpCCulZwwoTceRHzy3LRYEpEhz
         DOg1kOYiyyDxOtbdleEmqHYjgff3LruEvA3qOLLPFgV/WxIwTxDOF2HsoO3bJZKJkq6o
         uLXwJGsRjScwqs24viZ4RcQTGbmP+Mrftq3VVfriy7IVGZasIeYZKORAsPRUnC7SHb2F
         H8v4gKhfUPwKYv3xqywAOBt6Sz/8f5+JyyVvuoAy7LnKWLn9InJHGFBh/5nHDx+qGd4X
         cNHU9eGi8TiPe86kPl6V5hD5xH1ykYZPnBgswBv2eBfPAtedKAgyPn9xkM4uGZnujrCh
         VtsA==
X-Gm-Message-State: ANoB5pkEoVNqqJA2ag5laxqZfDi0iCZyEDiauchvheJBVqjYyu8kYXx6
	5qs2/GUP9V1TjCblATM1jTVKk3sjGujTgik=
X-Google-Smtp-Source: AA0mqf4LXjM90ep5Ny6nKjYu3ynZtg8sRG/pfc5Y1j2Nkslx214SoBFCMsvHN2edOXSMqI/tPDxKbA==
X-Received: by 2002:a05:620a:21cf:b0:6fa:1745:cb2c with SMTP id h15-20020a05620a21cf00b006fa1745cb2cmr51351548qka.119.1669745620157;
        Tue, 29 Nov 2022 10:13:40 -0800 (PST)
Received: from [127.0.0.1] ([172.176.69.173])
        by smtp.gmail.com with ESMTPSA id bc10-20020a05622a1cca00b003a50ef44a77sm8970005qtb.28.2022.11.29.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:13:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
References: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash-to_=22bpf=3A_Add_bpf=5Fmptc?=
 =?UTF-8?Q?p=5Fsched=5Fops=22=3A_Tests_Results?=
Message-ID: <dfe059e0-6d64-8e7c-508e-9aae327cec81@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Nov 2022 18:13:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5929540917133312
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5929540917133312/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6040859421442048
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6040859421442048/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6ddc47454ee3


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
