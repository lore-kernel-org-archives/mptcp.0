Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA7168
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 15:05:52 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id t16so6008575qto.5
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=uMVrIrDYVbJGCE+AT+OWzbxH5fBQngVq/GdiRbS+osE=;
        b=oLcy/k2Y+OjZCv5eY0jOH33oDk48+YKAw9fMLNSQsQt4vBn3Q0twJZ3W1rsEU1r0JG
         8lqQESmgJK2CfeE/dVUfbsTw7i9JAVnfO5dp08QsZN/1yGAQdaAMRtjgT85mLPipuh6G
         VB/DcEf9S5TsK2AVpDVL97LubRV6++2+FoWQTQVJi7pJ9FBCfFkRCwCMQ1az4QHf6zBM
         tYSJAWc+4UQg+4KLaUXuzDdmXpLV0IKdxlX2Wp1VnTeQtmTdLho7SU1RhVevW2fFjSB9
         ODjnSX40RDWoCZU5WAUbElZ/ac1EbbK4ZIsNhKFD9Nqa63W3F65eR72Ol+dTgGCG82fk
         JfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=uMVrIrDYVbJGCE+AT+OWzbxH5fBQngVq/GdiRbS+osE=;
        b=q5YxST6BQplDn/KhJt7LUELeP1QPBMhOdScT3kLzoWt7USaiQ0+zo6a7cVLtRqcgHI
         hYCbNiysPOWsVBobNXU43HLXFbzWSi1ZSSu64WpDvzN24ISYBJf/Ru/XvD5GHMSRAXUi
         oQfRt/N9yQLPHyVM9a/sJFq756qMU2ZYqqCW48+MTTNXq19DEdRtYcwN3cMsD083CAy4
         5LZXA2Pl7OPZRe3BcvEPvDj1AE9jdVLDOk3nPih7BodZXqx3FZGlTEvNgUikgS0WRvJp
         dHLVC+yyGvILiSnVloWDbK9Z0hoZc/vzqEcDQ1KahKrGIHrDQr0EiLIDVRiVyTzR0UAj
         iUaA==
X-Gm-Message-State: AOAM531vgx/7tM+RsyqM6tJ56+/DlcC7xbpIbNNoIAiWSwdaEI6V1nCE
	2r1aBCdc7zZXXWV8tbfIabQRA7idmTed
X-Google-Smtp-Source: ABdhPJxOqHjuVTa96oFvTJQnX1xibc/yua7KWqDmRAPj0bMLpAlhU0h3epx1UXLYux7sDY+q7mTI2Q==
X-Received: by 2002:a05:622a:170f:: with SMTP id h15mr7445021qtk.176.1634223951964;
        Thu, 14 Oct 2021 08:05:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.251.118.9])
        by smtp.gmail.com with ESMTPSA id m28sm1393535qkm.23.2021.10.14.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:05:51 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
X-Google-Original-From: MPTCP CI <noreply@github.com>
Content-Type: text/plain; charset=utf-8
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <Matthieu Baerts <matthieu.baerts@tessares.net>
References: <Matthieu> <Baerts> <matthieu.baerts@tessares.net>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default: Build Failure
Message-ID: <cfbb9e5e-a467-857b-6b46-467e668c4d87@github.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Oct 2021 15:05:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/1342334166

Status: failure
Initiator: matttbe
Ref: patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Commits: https://github.com/multipath-tcp/mptcp_net-next/=
commits/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Tree: https://github.com/multipath-tcp/mptcp_net-next/tre=
e/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
