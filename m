Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3B8472
	for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 23:23:44 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so5279067pjp.1
        for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLKELv8f0wlEbKvuMIST9y/0vnQ9tosCW9abzY1S6Ow=;
        b=Yyt1WOTd/hLtnCCAhAIZ1ses9K9IUE3iZmiy+QfXwVLk90hRYcqMsRu6DwgWGK/prF
         M/CW6cJmf0pxQcjnQerwCMXkfQlku2sG2/Pxk+nFb/ilBBYDZGrDWKZPP5L3MmzxC0P1
         nV4wbH1mFkvTJzvQMtdIk6AAoPRtjEwMaTln7CGeW8+0/pzE0ZDcZvkdrpniToRo3rIl
         H2fVQO9gMRtf7ooj0VosazMSazVHBYAH8jWNjYWNiFT19KT/B7CnoMRG7CXQo5uzoFLb
         4isKlUueNOrY5HyZjAEC9IYW9EjSuu43UkyU3w1ZdDUP2lFE3sHRauwRHZXfUP2Rk8MG
         AGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLKELv8f0wlEbKvuMIST9y/0vnQ9tosCW9abzY1S6Ow=;
        b=UZ8L43Ea81nTmt3Vh7PgDcFUGje9+9WouldzLoy7PyobMr7Ptoe/R06etRnqAY2rLX
         VpP/U/iPJVG6dZ58FlZYsDP9VpotknATYozxfwg5KmW2dEcgTe8UlcMdDAf93JkQxf+g
         +OGmOTj47BDtqRD7J2t86SM+H5VdcCzSpXq42badlnVS8FbLBdFPpUScdMy4avWxIMM1
         /Un7L/wLxWwnKKwBbkjRKr81YEdiz7uwq/C8SUxIO6oaDD3TFsmj5WCUXgGNrMowLRJA
         +XzzY8SDdw9sIfhYxnpN+O3pVNankTJ8b/pJ9otrphOScSmRcXdctUc2kl24fKZ6emcm
         K5Rg==
X-Gm-Message-State: ANoB5pmoJMYwuQ4PlVQoovA8QtEr/nG/4TyvbAmdryhAeD9LCxE1BLmu
	lsoyiSp79Ek8zhbhY39xXg==
X-Google-Smtp-Source: AA0mqf4EayEjsEU7OANiWELBz78G/IxIsbpJqAaf+4m3sbPKnQkQUSewRyxd61hKY8Xd7PW6o3um1w==
X-Received: by 2002:a05:6a20:e60e:b0:a7:8d78:6069 with SMTP id my14-20020a056a20e60e00b000a78d786069mr27164163pzb.57.1670973823637;
        Tue, 13 Dec 2022 15:23:43 -0800 (PST)
Received: from [127.0.0.1] ([168.62.11.101])
        by smtp.gmail.com with ESMTPSA id d13-20020a63d70d000000b0047829d1b8eesm7387918pgg.31.2022.12.13.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:23:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221209045925.20408-1-geliang.tang@suse.com>
References: <20221209045925.20408-1-geliang.tang@suse.com>
Subject: Re: mptcp: use msk_owned_by_me helper: Tests Results
Message-ID: <5b529cbe-3663-9655-a690-3c17ce785e70@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Dec 2022 23:23:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5326783529091072
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5326783529091072/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6452683435933696
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6452683435933696/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5045308552380416
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5045308552380416/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6171208459223040
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6171208459223040/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/37ca12499f3b


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
