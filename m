Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE84173
	for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 13:29:51 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id o88-20020a17090a0a61b029016eeb2adf66so9616730pjo.4
        for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=omvvmTef4NLZ2zjxaaQuFKAom+hRkVZmi+jVKNlqO4k=;
        b=dpBvnWpLDTCcncmlIT81RWgiGioR3HYbazbOxMbXbogXaWBuX6b8n0dSzo7eYmvTJm
         cnIJigJdR/kSk8AdIRA9a5K9RYvLdjiw26K2Z1mOTntnq/hmk4sEB7H+uzErdtyMMC2/
         w+GEwNvuHMSO+15nDH5WIX68E+g8HVij7iFdisMOqNvpX31G5QOiIJSjcSH8UXmKcFwb
         TC9ViO8WNWKUqwWSt/EG6MFfnrpp5jtx3+0sixf92bR4tNM12iRqTBAm7r4Bss3jk6+Y
         wqSMGVYB+2RaTSc8DcMVslULxwQoWwZyAuOX5aUzAYayjH7tn+hwxMYzBs3Z8zHPn3KT
         UOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=omvvmTef4NLZ2zjxaaQuFKAom+hRkVZmi+jVKNlqO4k=;
        b=U7dSpKRRwGNRsr4hmZO+vPOpjnDsQlv7kG/XBBt04FhWJqMQBoVfE2u8gxBM3zveGK
         JJEJJRS8xKaHIkfgLUyVwkhYZaeRu+35l3KI7sJRTuKK0mFurr+kSzBPdWt9lsLs3xp8
         +Zba31CunOKf6Y0SmAojBN5L+8TCvV4R3VLAdfuMOCDPN5d2SO/50DVi/erjTL1jP9um
         7eVauw/6cAul+XLe1pqOF7qpW38NPm3bMaCykyc44/x8OIHlMKfPzEnHSb9DBmTGiD7l
         6vB/F6sj9HS1UFRat6MDwQmDY63RWvSeaiMgJ1vHmceOPPWYlW3lkDMN+m6mAVhrCkko
         He4Q==
X-Gm-Message-State: AOAM532HhIaL2Lhdrl4j6ovX76ijA2dwCGgXFLf21yIYkEJtf6y+v2BY
	cQ8yztKZgXZaLaD2of2QpHT/3E+EYOy0cRLjVyeqBV7LQMHpWg==
X-Google-Smtp-Source: ABdhPJzkKwQt1BlGn5gUZGPGVAHqm+f4j4k2QvL+sIcGu67RQNi4NDEusc12vdq+7p4tpAnY25usJL/Nfq/9iWJUlwk=
X-Received: by 2002:a17:90a:7843:: with SMTP id y3mr13839517pjl.190.1624109390943;
 Sat, 19 Jun 2021 06:29:50 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Geliang Tang <geliangtang@gmail.com>
Date: Sat, 19 Jun 2021 21:29:39 +0800
Message-ID: <CA+WQbwsyZe=yzLsC6tAonfoOx382ktTOugui30vB4wnTmgh08A@mail.gmail.com>
Subject: The commit "mptcp: add csum_reqd in mptcp_out_options" is changed
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Matt,

I found that in today's export tree, export/20210619T070741, these two
commits, c05843b6d4d0ac6b66d5e9f151b3140a015ba2d8 (mptcp: add csum_reqd in
mptcp_out_options) and 64f0cb0f3851436973c145a05e9ada89baeb562f (mptcp: add
allow_join_id0 in mptcp_out_options) should be merged into one commit.

Please check it.

Thanks.
-Geliang
