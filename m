Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525D320D
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 18:32:32 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id x8so28902330qvr.9
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680805951; x=1683397951;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byrxVsQv8fDfZ0qxOwnc+z9JkZh7S1W6S+v0yrqGDh0=;
        b=Lb23UQCgFkRw9skYjz9GZpzSE604bNC5goXFJNU5qb85lvWSsxM38Q2TC7gIUI3iom
         EUsz8yuGBGJZSkjUMfwgg9hmdS0sdVr1yfr4palV5EPdmiNIziYdnMeqErHeN3QtC7JM
         MkI9gsEIenmaFotBjY1tEuWIcVwyJXZwBaxEaG/5fRzXEZJQZbF7Bis1hApDKVUmZD6R
         hf9brhqKglTdP1pBmlcNqPbhiLs7ZGtFHN3m7brmP/YoncT/q/BCPmKSGfRyOa613Tuq
         wSYuiQsivdPQmzyKEyABOZUk+FyhOp/nnXGI5x5MEIVSYAZvinSPmZQQ166BL/UfsRJz
         oxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805951; x=1683397951;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byrxVsQv8fDfZ0qxOwnc+z9JkZh7S1W6S+v0yrqGDh0=;
        b=tTL4NLhCEWlFFMGqEESxgEEmY4Duz3wryrobMdUZxxwuvNl8LzxOLgo7GmARuhyO/j
         Ks/GZaWGpKfZ/Z6xF7b++hiWtY7dYnKOz45ajWxW+hGjrhboPWMZZQGsKAnZ8V3P1IRK
         Asikb73ZyCO4XroTf7vGSYxRq1nyvqwg5DPxpi0kDisnnKJ0m4/3rrMcORGxB8xc9J44
         82DeCklR6/KAyJAVUST3F4idf7T5UTZ59DloWSxgHASqePtkJWKsojXHgCBGLItI/uOV
         tym1EADfbBjSuXhJQ1OIYo2lwHcsJItPH8pEXUhPjsPyZo35ulXkba2izBSVujfWkCPc
         SmCg==
X-Gm-Message-State: AAQBX9dbph3FqpSBJZQ1Y8JUYx1oR4pZDe1NOe8Rx0y+VcC1txUJNq0J
	9LzxQnPU2UrA0rtiTRFy5w==
X-Google-Smtp-Source: AKy350YosKvr2CKjb8bupknkRXfUC0GHzKCzEY5d+ng0US2z9WDY7W5eRwUht6mmvI0vDKl8rpEs/w==
X-Received: by 2002:a05:6214:762:b0:5c5:95db:859c with SMTP id f2-20020a056214076200b005c595db859cmr223209qvz.33.1680805951468;
        Thu, 06 Apr 2023 11:32:31 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.203.182])
        by smtp.gmail.com with ESMTPSA id ff7-20020a0562140bc700b005dd8b934582sm700295qvb.26.2023.04.06.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:32:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>
References: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>
Subject: Re: net/mptcp: use netlink policy generated from YAML spec: Build
 Failure
Message-ID: <eab20f71-e8c4-3ed4-5930-37bf37fef26f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Apr 2023 18:32:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3=
jvtoa88@z/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/4=
631535712

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7d20481ccf=
26

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
