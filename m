Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9415B0
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 00:44:21 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id p202so2879670iod.6
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=eJNPpftCHQ3GDZuwOy1JlRr8c8TQAVXQMrjXOH7R0s4=;
        b=DDrekmVD2LDiTmXeqb4aZg5EpidcmijZnrNxrIkjGTGhktS18hIgtfBVqB7sMCrJ19
         YGap3CgiIlY3gh/2DIB8wuAPZNJQoSxmaXmcOmLYxCB54YTHzBSTj7Etvayt7NXxp7UK
         x3NPXln7eoe7n+V6eZCawdSJgQj4dR3nVRLXT8czWJwgHiTqN16hXWgIW4UE/SFoB/Nb
         EsCjRdF27bWXCWRBeUfYfWcsMB5FAhrkwyRS2Esr2dBrWY15+8IyE5UPLKojaW4Q0+Bg
         u/7VLKZmM1j6ka6RGaVEXCcUvgUW+rgrfpYVrJ4C9qhQVXwccxY90ZmMJ0UBMnyKQF6I
         kq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=eJNPpftCHQ3GDZuwOy1JlRr8c8TQAVXQMrjXOH7R0s4=;
        b=DN/LkLwqDOZvEk5yJtjfIY/N6LktC52Us2WbqintV78m4psD2OZ/hhEWu3PK7WpwEm
         S/+fZ2gFuvn7FWmoWfTn5CMtWdltyQXHsDZ3H00pm1bbRIoSH7A/RztJMceLfMwXA7JG
         c+vw65Ge21qnddSutTex74JDI7eR0hneEoWpe/e4gMqkd+tVcY9dtcXOsT0Ot4R3mR3I
         QCEPIDEiWV0p+DLPjjbgUXeGM1sv0jpIJkqWLLxpwDlfLJn3Wsacj3hs/ex9/YHlR/IV
         t9AcZn5OLMbl1PlW4Oi30Cyp7Z/4t7hoTBuj6ddqyFh3T+VjEFtuN22w054xIFx9MICO
         5lag==
X-Gm-Message-State: ACrzQf1yxCnzb+LH+SXIYBAc7BZLaiXerCZraYarJSAv/RtoDUrPPsKh
	zgWTNpjd7kPdjply3/Rx9D5zkxMFQJgm
X-Google-Smtp-Source: AMsMyM6WUSzv2O0qab5y75v8o5rEqfIzyIl2LZMobALhOR7yFx5ma779uHDKM5SRaLR1YfVtO98BUg==
X-Received: by 2002:a6b:ba0a:0:b0:6a0:cf7e:b647 with SMTP id k10-20020a6bba0a000000b006a0cf7eb647mr2969160iof.137.1663893860930;
        Thu, 22 Sep 2022 17:44:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.86.10.5])
        by smtp.gmail.com with ESMTPSA id y13-20020a056638228d00b0035a6ee24e09sm2835200jas.15.2022.09.22.17.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 17:44:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220923001530.9722-4-dmytro@shytyi.net>
References: <20220923001530.9722-4-dmytro@shytyi.net>
Subject: Re: mptcp: reuse tcp_sendmsg_fastopen(): Build Failure
Message-ID: <f86caae1-31b4-281c-5abd-06f01d3cec56@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Sep 2022 00:44:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220923001530.9722-4-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3109657443

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d6a6496543d4

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
