Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB22F33
	for <mptcp@lists.linux.dev>; Fri,  5 May 2023 20:39:53 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-76372a83c8eso52230639f.3
        for <mptcp@lists.linux.dev>; Fri, 05 May 2023 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683319192; x=1685911192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukoSPckyo861p6byBkF85oK+aFISJdVZOuy553X1aqI=;
        b=K//LFjlut11F1MAkz7rGQWYL7oouIICyaR6G4X0t5+i7pGhiS4UYjf7e0n0j9soTLg
         oNUTwVuF53faoIjYEwQenri1c5RaPgO6StFhMP36996z/ZVZ120UdvW4fgyrx5sU9W5n
         fV3fBvYRu5au0cS7ZhUBVKfNsd+HGXkb+ws0ptU4krdBhJ5HC0NChWOjIcaign826y0r
         sVplXsejq0uOsa2AhVJKY9zKAQ6U1L0EFYa/fvm+bQLXfAzSRwAzZbWujIsWUzIVYVHN
         LDEV0hEtJ7FAZkfEjcf0DiyShrCna0z8HhBvfuycOcUivGINLNiW4cPA1bHQ4ClyzE75
         qPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319192; x=1685911192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukoSPckyo861p6byBkF85oK+aFISJdVZOuy553X1aqI=;
        b=NKMSRR+gY3OxMjn+WFswYmWfW/tiumgFqTZn8pbk+l6GjeUAAzgurXNGhfa1TZQWaq
         lcmNwQz0zUZD3/4ehcqdEp0hH3Ilb7h9n8aOGTtTxeTKRqzYV5AakICnc25GPh7I4RJ2
         fE2HyBU4ww/p4wNMqns+lxJByA5HetxI/YXeZUCww1HuEPQ5sIkW2nGRZocs3fr+BBch
         FpYIxDkkGvcupBI+vN5tbOXlrbXoYx5FhukjRtmSIeC5hZnG2S5KBVVLjlt9DmcK8ng9
         r4DV1FoEsi7JN7PkMdl+Iq8F04yIAiMl2oRVs8e+2Ds635+wgZY0BcV6kg2e3sTZOsle
         79Ng==
X-Gm-Message-State: AC+VfDyT0dLdw7Olv1CJx/Kr0N8Ng1xEhkjisYtilO1FQRgOtWLeMcl9
	Jsc6Js7hYMeYWCEHVWcMY0pZHLUIYw==
X-Google-Smtp-Source: ACHHUZ4vF/K6g69fCIzyG3XfXASgtYy9EgAn3gUVNEgofYm7B2IeYqtaoK/l1IrnJs6kP2msq74ebg==
X-Received: by 2002:a5e:aa13:0:b0:760:6412:f5c2 with SMTP id s19-20020a5eaa13000000b007606412f5c2mr1703477ioe.3.1683319191994;
        Fri, 05 May 2023 13:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.243.240])
        by smtp.gmail.com with ESMTPSA id r18-20020a056638301200b0040fa075e5e6sm188062jak.102.2023.05.05.13.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:39:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
References:
 <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
Subject: Re: mptcp: fix connect timeout handling: Tests Results
Message-ID: <9b42809b-3f13-3320-d6bb-4489ae11c65e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 May 2023 20:39:50 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5039504482893824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5039504482893824/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5602454436315136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5602454436315136/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6165404389736448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6165404389736448/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6728354343157760
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6728354343157760/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4122da9e7294


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
