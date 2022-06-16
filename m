Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583A7A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 08:17:04 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id h7so427442ila.10
        for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=bM7lgwjgfZ74Mq4INrX0vnAVQGLlTtgdmWAft10/4us=;
        b=UxfKw9/+priYKgAY1izJQdVSI+Hi9UutFfIv204L/jJTz9/ccmYJFUYSX9QIjgOLON
         9SK1nsQr54b6iD29QeeFmdYwbFWAY8BaE+qLIAkbOAboeb7uMwc21InJBfJ5QDYfEI9+
         pInX+U2o7wCbzRsfu3JlpMya+NgCs8QAQpLzym+8525RkakbrisunVKvrQpSBdAXHfIw
         aD21jXk+aNt4Dr7lV8KZdiMrXAwqhoiE5b2stcoCSSRET985O8akTfEse3F5/OEZMk9/
         HN5krVXf4n8pGlsYMPkT9GLpQ72ukEKcTPydzgt3MzEAxXXA303U936kWhVgSH9LQb7w
         Y1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=bM7lgwjgfZ74Mq4INrX0vnAVQGLlTtgdmWAft10/4us=;
        b=CSa+UHhDSgFN471tIsBRx9t2ByUWL9LKTZ9u1G6a7vFcCkJOJbT+8pkiOslATyrlnI
         /RFH6pY8sfn5YBpGYbS3F/9pE5kai2UJ0RknEXnR5KET3NZPOGpOnXZ0jWHdFMk/39q5
         aUCaNqAmPf6loiY/F1p2No5HQndpmI8/mq2or6SnsO4rd7GNkK7YF1f76yXPH55u48GM
         9bZlTxKNgjA3RXZDMM2pB1ZhbF0fh92u/lVgWa3ojhnuxzf0YiF8XtmzltGXhbuKHmDO
         4x6SOyC3m7aUGzTy4PMETqJ/eYa4v65w1UlTHcroDoXhqwaEzJ2ewwLDazgBZjWBQ5Eb
         WVYA==
X-Gm-Message-State: AJIora9FDPcLNHJKP9lb0NCWjdWonJHrAHVVEpS0e0zt4Gd5YaOkzBEy
	aspSYAg7vlTFqkl1ef58lQ==
X-Google-Smtp-Source: AGRyM1tzuT8I9bOgxXNNZ4PzAa8SmJDTOrhN/OYjhRdNszvi98ythUzUCQ6GDDaPEO+5Ehd5+w7m7Q==
X-Received: by 2002:a05:6e02:20e7:b0:2d3:ca08:64b0 with SMTP id q7-20020a056e0220e700b002d3ca0864b0mr2200621ilv.195.1655367423908;
        Thu, 16 Jun 2022 01:17:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.67.179.250])
        by smtp.gmail.com with ESMTPSA id 8-20020a92c648000000b002d39719b34dsm669621ill.87.2022.06.16.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 01:17:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
References:
 <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: more stable diag tests: Tests Results
Message-ID: <1ac0b1db-da8b-8140-f7f1-03a5afb070fd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jun 2022 08:17:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6186585342345216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6186585342345216/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5623635388923904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5623635388923904/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0ae9fc4e3450


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
