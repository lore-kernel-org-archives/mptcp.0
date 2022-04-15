Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F6320E
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 12:24:17 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so11675295pjb.4
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=mI+z/RnYsrs2i5SI3V5Vz6GezVJOrR1HG1SH9ik1jDM=;
        b=JD7Wuv/ieWhnr9bnKfpOWeYNS3r/vhkfB2OcpIHVIcm96uoDJJBhxJ83+Zx+XwTj7g
         edUozD2J/FrzSiYGaiL53M7A/kODrt48eIj9d1l5BZ7BP9N61lK4ODZJOE8TPqnO8ppv
         +kULM4DYePxihedo3fs3nZreoKj+pobQ/funj/cfUSRvSQ/JiB7apiPxrQod3L1SqKUD
         tnSPzuYwCmq4TYqGQPLcrQjIC0MjRSviiE1kGjrvR5hCsKBxGGYrRWjH2rbkiL0i49pz
         Agk1t7MmRJc8kF2OR0iKsQIY5blmEXRdkmQlczpeuA/37/Y3yQZNH3P16Y3s2FWaLFJZ
         e6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=mI+z/RnYsrs2i5SI3V5Vz6GezVJOrR1HG1SH9ik1jDM=;
        b=7TDJti6M8kW2dJOmM6V/caWXwjrKZjmyOXoZL9kb5ImU8/MWdyD0HB4gfRK9iNXhhv
         vKKQ7lJIY1XZV8FwrUW4PgB0zStCffWKPKwz0r6UQwPWbB0xEhFO0PGg4q2sBMnFMnwD
         k3jHuaIEc5xhVN772dyisR4OhbUuDuswA1ue9ypSiXulhcC591hOeQFmQQYazGbP1Ooe
         xCdcm260R58eZKiBWybYz4BgTg8y/dpVVu/ByUlP5lYFCJhIhG/mk3qMP3LM6hgBp5a5
         DYoPhCkYNYMSO9aaR4pVnRVEBsG4tPcPDNB2x9A2SAsYWdu+g66rT9Up/nDaueqsEZan
         BaDA==
X-Gm-Message-State: AOAM532rBe95FfzEOwL0VOzp46VYIDZLsjjTPE4hoBLfI6k+lIBlOA31
	KDJyo4EuEuP2RJiFW8eskSaTuRqTIWk7
X-Google-Smtp-Source: ABdhPJxUbp0b+9l26zZajDyV5hW6xkGjhL+cZ0hw2bKX+8VZgPbnTiYiCZeQOtjTtnwO57OfAWxtyA==
X-Received: by 2002:a17:90a:c70f:b0:1bf:3e2d:6cfa with SMTP id o15-20020a17090ac70f00b001bf3e2d6cfamr3967131pjt.70.1650025457018;
        Fri, 15 Apr 2022 05:24:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.72.120])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b001c779e82af6sm4500911pjf.48.2022.04.15.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:24:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220415104550.1037339-1-matthieu.baerts@tessares.net>
References: <20220415104550.1037339-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_handle_local?=
 =?UTF-8?Q?_addrs_announced_by_userspace_PMs=22=3A_?=
 =?UTF-8?Q?Tests_Results?=
Message-ID: <a3ecedec-8689-b0cb-d7d5-c101330ec7c4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Apr 2022 12:24:15 +0000
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
https://cirrus-ci.com/task/4810986858217472
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4810986858217472/summary/summary.txt

- KVM Validation: debug:
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5936886765060096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5936886765060096/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0e3466dbb11f


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
