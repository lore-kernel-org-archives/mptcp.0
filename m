Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3B2568
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:17:39 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id z18so5072208iob.5
        for <mptcp@lists.linux.dev>; Thu, 05 May 2022 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Rc/gvr8TKlNL2EhgwM7KUfgRGbcr8pIGz0LLwUXKWqQ=;
        b=jj6FWKGmAEHJMha7/BKnm0iFykNRI4gQmnz3giCRJnEHIZCBJRL0XTv7brnSVWsbt9
         oUC18eUbkX89idqOB/JfbcGAaNmC063eq7WRZuJ1buiBj0YkuI19dRZdJMhLZbZHHZIK
         2nJ3q511dflZplhA0ps6v/jsXIBZtPbKGLY8YrJFZXBFe/rT2NdBNvLpaHTc1i5+Nc4n
         SsgOpsCVTXtaYeHNp6ZHhkAG7X+86z3XKz49cmH01D7DU1ZOwZZyJVK8QjC3NT6WA2Ad
         CTQmMbcRCXO226Vwqf4TCmWKmMygQv6IkWTyiQVymJYiznPvOI4esxyXgs4+Ku88NCNW
         ZyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Rc/gvr8TKlNL2EhgwM7KUfgRGbcr8pIGz0LLwUXKWqQ=;
        b=fc86oN/BLHUZgG+yIjI1IQ07A5D1TsCw8OGONWCR3VtAQ6P2oTu6J3PZQ57gyiGZUG
         yF8XuEJL6BB1/RIKNR6mhHj9LaGQ1KlLqFWPWHQRqs78F5GYd5L7nV3KgG9DKhWLNdOr
         20esAeks/qYpK8Z275GUDEgy9ihzpff9JNS2ohYh0cPuwj962VPj85kGQE5BC5zf4spW
         s2FMSV1sh/5CrHc5/rTPmQifCDw3VONRFCaR5VrLF/5WkyXqYOM9Vl/CApWxGg5nPsBf
         94A0FzhsGX/TzrGGvSODPD6o4IsNmnFbrgH9TEuA3+/wefGUIkn1evNIXemIi0feV78a
         jjpg==
X-Gm-Message-State: AOAM531v6UpNtXROyey8UDpIkePgjBwdtDbif0z5k1WWyxxMAOXyMU5C
	GYMOpilHz9hypKOZs27RXw==
X-Google-Smtp-Source: ABdhPJxRG6Ssjx7AcFeuFB4YJvWrbTDg6SvwVSOApreCOkXedfKWKIFhJ/QerClaD0pYwa3Oit3H3Q==
X-Received: by 2002:a02:234a:0:b0:32a:f07c:e8 with SMTP id u71-20020a02234a000000b0032af07c00e8mr11579611jau.87.1651763858561;
        Thu, 05 May 2022 08:17:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.12.125])
        by smtp.gmail.com with ESMTPSA id a10-20020a92444a000000b002cde6e35304sm473669ilm.78.2022.05.05.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:17:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
References:
 <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
Subject: Re: mptcp: fix checksum byte order: Build Failure
Message-ID: <f99a64f5-7aa9-ef3f-02ae-4b69de2c5a3c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 May 2022 15:17:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/2276563461

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e13b663008=
d0

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
