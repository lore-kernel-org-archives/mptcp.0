Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9ECEBD
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 10:57:45 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id p186so3317993iof.5
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SK/T2+D/NxgmLl0RKcQpnKHLygLn34Qh1H57/NCil4=;
        b=Dv8bY8ysb+OrDE/Uf7nGZRUqJhIX3rsNIHnlXXyZ8AE8bdK6xPbKZVeCui8xYHtIAO
         g4KSFAmqQ2YUoQj0l3QRq6acS8qJVVhXCYLfHDkjZT1qTzIccnw2QXhp6BaKWweKuniZ
         LOA7s/mAqSog61FTBUer4sSuMKJwAuM9CJHbFWb0aEb5dLpHTsPfwJzolSk7bRdBcU2T
         naL5yH3gnh5/DC1swnBVnYE/kF5ARx6mawHVxt/gyV8sK+HlhrKDqlQ/isKxumHNoLoy
         oSrrlXBfvPS92aNdysv+UJaYPv/XLLXHxOk/zjWhG8i1CdjNjLakxYmPRJgi6/Z8gGip
         SKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SK/T2+D/NxgmLl0RKcQpnKHLygLn34Qh1H57/NCil4=;
        b=BBA/0cfDU/3YYesw81jLcrlDgymvKm2eDuzK20+EUYlysSMoYkZFDJqFmqUdPfIV0F
         8V+OBUT9Dphv70ZkR7A8A5+oH4vcRYHvtod6BNHaGkKs0lakeKdCgdB3XswKblJqZX+s
         M45PUw8S8xAsIOgr425VryYi5lDj5rTtWOF8w43UsZMMEIiXatOrjoiw4N/09o95AggB
         XEP2bDRFVnzs2TFdqYe/BENud/57K/y7WIrAoXnHzAlUURaW/43G2FeqpHeIrkxrTJQU
         LAyV/L0zDi2RwHd4ofW3UVi/Yan/E+mDWqVmsIUjEq7izPTrdHTSISWqirA0tXbhR9l/
         ftbw==
X-Gm-Message-State: ACrzQf3dLUaBHSoIFHcoqRfNw3HbMoCLz7g/e8c665k0Xw+0mG3fLMeo
	6D1/yJeCmhmAer+pa9qdxb0LoZWE/dak
X-Google-Smtp-Source: AMsMyM4eZYSjXvXKxX+64zeIwPRQbUpFCezjIT5PAIouYzTAFYikdttiKCBZ/SGN7YxSn4SCXa4VkA==
X-Received: by 2002:a05:6638:264c:b0:363:450b:86ac with SMTP id n12-20020a056638264c00b00363450b86acmr2260378jat.116.1665140264364;
        Fri, 07 Oct 2022 03:57:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.89.62])
        by smtp.gmail.com with ESMTPSA id t7-20020a92cc47000000b002f66aacb98asm782620ilq.70.2022.10.07.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:57:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221007092922.13169-4-imagedong@tencent.com>
References: <20221007092922.13169-4-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <740dba9d-1202-95ef-6f51-22ac7c5856aa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Oct 2022 10:57:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6562201610747904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6562201610747904/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4732614262128640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4732614262128640/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/83a72b913f3a


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
