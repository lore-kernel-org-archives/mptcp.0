Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248AEB28
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 08:02:43 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id y6so805822iof.9
        for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 00:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8fa/EiXtbopR6Nwou3mjZ7cKIpApJ9wePqbKGHhteQ=;
        b=a/jVVAGKFrCqbThZt9mMAQkyFr0RhPBCaVp7f604+3bH3ylPEmZOd3xQ4LK07ySkRg
         9FA1yufxjY8MwusMI67iJ/L18D1SU7aNjwZI6OqPBIim7yvK7FCCnHxBCSUEhmfIZQVJ
         rTpdZ30c9A3Y/8EKQDn9Q2Ukau0MaDlDsaM4dthI5Wg88dyS921m+Ak6EM6YQkI/h0ZG
         hlQex5atrcdilkDLYv2RW1RE1oyXAEeyhp6UjlyYLm979q1FTXTKDyQ4YZkYDZo6D6O7
         ohHdmul3uO6am9nqJZea8dqaV5Dslopq9BTV6CYFfnUdSzeFhKGO7MpmV6xDOUw4csqp
         FOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8fa/EiXtbopR6Nwou3mjZ7cKIpApJ9wePqbKGHhteQ=;
        b=ica/J7J5dIVv25wmnneZykHDHm3n3dNnrxQZpW0RJUZoZ08E5kFHgEApAAs7ONv20G
         hOPIccOng4L0MbFv/A8ygfjbc08K4OBPc0OTPCnc3xrgN+PBR/k5ucRsBIR+kXqjM8CS
         6K7illmcLpaIVuQ5z+W8GeO8O7jlgcV9dwrOEDjOwZw+IuIOrIMDVcGgboNPQncNFaMz
         +xUZYp5BdPx86xjJN2tycNCDBBSxUddGeAKkAUyzDyS0rkfy6Yb905nWko0/6rjG4XGR
         XI2z2f8P0mFsCbzIsOYz3qCPS+AatnqGDhSKJaonh3cV8H+PQqyH99sdYhd6WZgR8gEQ
         sYyA==
X-Gm-Message-State: ANoB5pkheVTcT/zeZGu7539tbqVqZq4P6bCFSf5OPlvqFoSLl/fsyB8e
	VRwJZOGYPzjWpWCHjVYQVabG1tXZ3Sn8QY0=
X-Google-Smtp-Source: AA0mqf6sWu5B+KV/yZ4hiCd/FHxYY7sInLIa0PTuoLofWKCRCByR2Gpv3QLbWofWa/B0OGdQJGJUJg==
X-Received: by 2002:a02:6d6f:0:b0:375:c16b:7776 with SMTP id e47-20020a026d6f000000b00375c16b7776mr587677jaf.54.1668672162262;
        Thu, 17 Nov 2022 00:02:42 -0800 (PST)
Received: from [127.0.0.1] ([52.154.178.188])
        by smtp.gmail.com with ESMTPSA id y35-20020a029526000000b0037586addbe9sm30512jah.88.2022.11.17.00.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:02:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
References:
 <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: listener test for in-kernel PM: Tests
 Results
Message-ID: <ed229fef-6f30-de62-c7d9-617840b7b1af@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Nov 2022 08:02:40 +0000
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
https://cirrus-ci.com/task/6305794950430720
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6305794950430720/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5653956353851392
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5653956353851392/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/49c535583971


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
