Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D617D4
	for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 14:40:45 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so6490925pjj.4
        for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 06:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jko5vvUKFmMf0ocMxbpYHECOrNulYyWq7RRgAIeGTH4=;
        b=XifHflbMlMvw3A512cpqN8hN+BBR5H+FmkIVf5v7+ebcJeY+LJczCEAAK0PdvNlaIG
         KnEniqZiSIPtUxbI4prBn0mf1pjR4L8ijBXjPLMC9HtCJruttNffip/rBisN08YXLrBE
         ggizkSNrx/ePir1AaQUKgFRNphVQf9upgpP6dc0ReYX1g1qQ0Kr7jt28DKfgVT+H6D20
         JIuC3AweHaQARAv62HpgUt5X2aYLWYLWrMs9m0570p4Weo51awvkIS7yZDhqhRQr0wHR
         Lf4q5Bh+eLULKdQiY+PX0yqEWBAaSOeaurCCthuOZtA59mJ0RA9cCxgeQzv2JRXbs9QK
         Hkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jko5vvUKFmMf0ocMxbpYHECOrNulYyWq7RRgAIeGTH4=;
        b=CyuXwhs76BhwrZ7E7ni0EKZh2xJ5Ip7YUiqgsMnRALPprnOTsDmnIYRqhK7MAC/ztI
         n32a1lSs9Vz+YnwRJDHcQUQoUkUeins+05yFtnZ7rSxWz90y6ixFlnPHMcP5OQGpQ66a
         AUzFA60e/dEA18dGN3mbHJhyT0HaO2JksomgdFf6UOMvP1j+WViwR7i+0eKnJR6RWP+k
         CTKSJ+IlmyyH5IzzvcUFtM0AzRGwUBF+9sHLoZWz0AVdVzXj7kVhflIdVsmy28oqntdT
         h3BrjFN0TbWEqXEISLDbwMzdQenMdVfMDzseCEcv6Cq4Ozs0oaqOtP9C7MKEj1/iXHU6
         R1OA==
X-Gm-Message-State: ANoB5pkKhZCR4/bOBdltk8GYFfR5fR3WK/wjdbVt4kAk/pwACmkJfdrK
	9fH1l/Bz2uw9I8vTwN5hqg==
X-Google-Smtp-Source: AA0mqf6PDyoAa7WTE9sZVcTyr+e7coZF8q0lg8RjKEGjsZsSWNGsIUTRC8Iu/sKrYwo4m21b80RBUw==
X-Received: by 2002:a17:903:2055:b0:17f:b05:bbc4 with SMTP id q21-20020a170903205500b0017f0b05bbc4mr23823777pla.41.1669473644740;
        Sat, 26 Nov 2022 06:40:44 -0800 (PST)
Received: from [127.0.0.1] ([20.66.67.155])
        by smtp.gmail.com with ESMTPSA id jc21-20020a17090325d500b00176d347e9a7sm5394515plb.233.2022.11.26.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 06:40:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35f7d90c998235855500e6d95dbefef988cd2bf3.1669468340.git.geliang.tang@suse.com>
References:
 <35f7d90c998235855500e6d95dbefef988cd2bf3.1669468340.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_listener_test_for_in-kernel_PM=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <ecf1aed0-3de6-f8d0-e6eb-55404fed2875@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Nov 2022 14:40:42 +0000
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
https://cirrus-ci.com/task/5174546332909568
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5174546332909568/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6300446239752192
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6300446239752192/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/638027e663b7


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
