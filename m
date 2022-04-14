Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8A3225
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 21:31:32 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id ll10so6232103pjb.5
        for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=FhNZIfG4l/k8YJyD56FJ5b/4JkhgtcptURGOdPTJjbE=;
        b=YHTRGHPexivJ4PSdB397n20S1vfEIpTGmviK6jjU8YGcO8Xpe6lNyNlX2JCv63R0rj
         EGVb0QTqbLDC11xpnEBwgBfRIOrT+qdDdFahAhYL2ORcvBBr3d9UjT+PZi3ZHJ3cj3wL
         Fib/eWvO/SPyOiPGeqcYVdCcT71xfcYljdrSTbLEjwFMOpbDJQcGSK40QcZCOkBafjjZ
         zl7obG8AdhklnOnZw06z4uPwWsLzUtCYYeoQvdYEQZ/ADgvNcDY9RiCxhx7r8WDoaYLQ
         3O+s+dAyL0ZV7Fr9URjkO0ZYXSaPDB3bWMLAlDvnq/ox110ijU8jegVxr5dl01AAQnbl
         Fi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=FhNZIfG4l/k8YJyD56FJ5b/4JkhgtcptURGOdPTJjbE=;
        b=TykstqG55hO8VbazYJP0hnETpNj4YsDCFikG0WhSBh3quEPz4x+Poe7avFqW9yw025
         2o2ZaCfc2KznhpTMcl5HnAjVtm3AyC5Q81lu9jxaClhNo9xIkFsM6wyOaroWAVD4NjDj
         RSRCtifp/4BFT9nw7q/r1xJagCQ2GwRGvd00pvvBGFmGoIaavmpi244NM6abc6Ue+d8L
         i6a5FOOJB7JcGd8M4Ot+9IVRQF0VIuqU6CXM/c9uJVw6TrUmGzkFmFWWgwJKjB7RcrL/
         DXPuQfDB70MyiVtTnPjXraOhVgW3Q1YzUhBEnObAVWRa8KRt22PfdZspqA+CfBgjGSqx
         v9ng==
X-Gm-Message-State: AOAM533qB/a+UnXkeOkJ0C/as2RzyXMRnm+2jsfN3ifjTdtbuTE6sU7f
	Rc4/LpyrNT16J8j61M7lXg==
X-Google-Smtp-Source: ABdhPJyIBgjM8yJZ41HnkpeNK8Dx2AfHKZs3h1S9xTVhPEyrq64mSL2IcIzf1EtpG1dpZW+hG6t//A==
X-Received: by 2002:a17:90a:560a:b0:1bc:72e7:3c13 with SMTP id r10-20020a17090a560a00b001bc72e73c13mr574959pjf.246.1649971891523;
        Thu, 14 Apr 2022 14:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.156.215])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm2658044pga.77.2022.04.14.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:31:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220414211920.1987961-15-kishen.maloor@intel.com>
References: <20220414211920.1987961-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Message-ID: <63d24556-9155-ad7a-7054-c2cbe97c500d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Apr 2022 21:31:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220414211920.1987961-15-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2169678716

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/273491464f4b

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
