Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D3C8CA
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 09:37:36 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-3f6b24467deso4940621cf.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684921055; x=1687513055;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n7B4K/21IGKzqScJRQs9DrmsHYCpQI7ak0AebVDKcQ=;
        b=cAzUVVaPhhgwuHXIRcQT92Dl7f+koQFd4DjwT7Hn8aTozPWId/yF3+8bkwXLGK9sS5
         jIUaPlfLJVd6Fpz8OSVbUBhaZRM/5skDuOoraTwW5VGo4XF1JShn0cjAgOlgfrqTT1zG
         GLOqOdZkGUZ9s/70/+l+rYCyRXxE2cYHwANM1BWkqCqJOV6JPS3Swg9kdC73i0nV5T63
         aP6DqXf/W66I+leqSmlVs5hXBS+RwaJJ/25UCvKXjvMQ1nAnLh+pn/t23Ade8xaqpc6l
         p1JPHx2V4Udv+OwzfkthT76gPAd6Bpn0K/3c5wpigs9rXNW/QDK9l3sjEHB9q5rhQHd5
         +PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921055; x=1687513055;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/n7B4K/21IGKzqScJRQs9DrmsHYCpQI7ak0AebVDKcQ=;
        b=cqLYwbj0FGidTwKNLiB5mG6RpD8LtzFr/6MUUCYgDcX9BgoCUFo8xVqCPnZq495Asv
         IzKDzYn6Mc6ZkjLchG4vdREjjUEwNCYEKXta6rh2vaHoqWRlugh1nek6F61RQJ3sAmwJ
         aY5M+vDOrDRM192ZjVTGRmMHY0bTLejOYbdoc7njJi3pWwNoElnvsEf6YZiRwlez05u2
         zOpjC3TYhDoJeGA9wdOnHimWRbfVooJQOYXn3Yh0ChVZkPw4rYjKBE2mzP8OW3Os6wrj
         l4NjPBZeK3TQ/Q5VJr6GuLauvxb9HgOeru/hcRMFQV490bjTvVX4iEx75uEw88Ht/3n2
         LIzA==
X-Gm-Message-State: AC+VfDxUEwRFnn7WuEQzGg2qdM0zZXpJ/LIfgRU56PVTciQHtkyb+3fw
	qkNdusv2MjomPGW55ci7mg==
X-Google-Smtp-Source: ACHHUZ5GW5FpcC+9KMFLCbsJ+XmF7uEZeerH2BiovfeepCmKUYSolVQCwUJhuTnsmFBnXjlzUb1i/A==
X-Received: by 2002:ac8:5ac4:0:b0:3f5:1ff7:db72 with SMTP id d4-20020ac85ac4000000b003f51ff7db72mr27744069qtd.22.1684921055151;
        Wed, 24 May 2023 02:37:35 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.202.229])
        by smtp.gmail.com with ESMTPSA id r14-20020ac867ce000000b003f532993912sm3601567qtp.74.2023.05.24.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:37:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
References:
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
Subject: Re: mptcp: update userspace pm infos: Tests Results
Message-ID: <dedbf5e3-11f2-ca9c-273c-4d3b5af20951@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 09:37:34 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6288369974509568
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6288369974509568/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4880995090956288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4880995090956288/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_join =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6006894997798912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6006894997798912/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5443945044377600
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5443945044377600/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fbd32059dccc


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
