Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616737A
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 05:15:21 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id bx5so6473813pjb.3
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 21:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NhdZl9b5wYTWThlnWK098NCSCUiTadvslSnbW4VjPi0=;
        b=fzEy3b5Tji2Z4tQ0V6otlR8SbGhl4Idv4ptE4V3csx/7Z3/8lWJ3fy98Rd/n6l1MKt
         RmnHiSg099Lf1ckzxpfAXc+b8bSOvkqQvlXWbsVdl8RuZmmgRs9iK7x2n7Is4p964yaP
         r549Y0hu6+/vAszPpaTlfzhtKW9ukeYyVmg9OcayAyXofVNpScpQtohECKt9UAUIJ3dn
         5ZWKHlcx+ITm8AL3glOCVP8qwIUXEMsl2zGAaktRQyQTMLpuS3vIF+hNpeiOkP/7PwcF
         8R1t7bDd5Idf2uarahiq47y6sEWvZa3MEYuq7Ou9AKmHMWff4Q3WVZafKrDGKavtXnpe
         WaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NhdZl9b5wYTWThlnWK098NCSCUiTadvslSnbW4VjPi0=;
        b=y3giQmMHwkR9bFE26K5jRUd+JbRSDDTfhztOlwoPmZZiZ1uIYnz6VkapDxOeo4SQVU
         +WDXmSTOr17bNHGx8a7oSNoUuhIiVvPhUMc1hJZ7HFOnus6OLyYNsRFbLiAgseKH+/f6
         DBcz107Qd/MChPexN82vuZa1sN+2rN4xjeAf9Wkl6k8KAoYWgE2mVsjDkm/uwxmCqZqL
         1/F71Y5sG//FWsFo3RU1U8DS9BQABOzWw+NutZy4Yf+SmxwAyxxszC+nRjkJA930Tsl5
         DDspqxjhHKRKVbzCprPWZhSlJG6W2RwmzHWFoqul7wk6y9KWKDjMnjQvm6ZiKkIvr1i6
         RuOQ==
X-Gm-Message-State: AOAM5322/AXDPGQS0pFxORK2Ep7olz6dP/TUwTMvzi4pD/e6TbgLUmup
	nfZzc5tMgo94079MUSHwZ6WM1BXRG1eVjhY8/XnId7zi2IRspb7H
X-Google-Smtp-Source: ABdhPJxYUp5BFW+UF7QTU2hDQmlYHlApVN1wDGnhBUnbm6VoBpB4gvbPHZEAT90UcSoMbQoQdPcy2gRJxkwN4sDxj9Y=
X-Received: by 2002:a17:90a:4b45:b0:1be:da4b:a56a with SMTP id
 o5-20020a17090a4b4500b001beda4ba56amr8947112pjl.82.1646370920740; Thu, 03 Mar
 2022 21:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5b92e547-12d6-91e0-6636-e98b3dffa27@linux.intel.com>
In-Reply-To: <5b92e547-12d6-91e0-6636-e98b3dffa27@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 4 Mar 2022 13:15:09 +0800
Message-ID: <CA+WQbwt_-s-EkCFPLUF3HCAS-dGrjcZOW-Y=LwWrC=0jCf3sPg@mail.gmail.com>
Subject: Re: Reordered MPTCP export branch
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat, Matt,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B43=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 12:15=E5=86=99=E9=81=93=EF=BC=9A
>
>
> Hi Matthieu,
>
> I pushed the reordered export branch to:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
>
> Branch: mptcp-reorder-export (da80d856dc17)

Please move the following line from the commit "selftests: mptcp: add more
arguments for chk_join_nr" to "selftests: mptcp: add infinite map mibs
check" on the mptcp-reorder-export branch:

+        local infi_nr=3D${9:-0}

And move the following two lines from the commit "selftests: mptcp: add
the MP_FAIL testcases" to "selftests: mptcp: drop msg argument of
chk_csum_nr":

+validate_checksum=3D0

+        validate_checksum=3D$checksum

If it's better to send some squash-to patches, please let me know.

Thanks,
-Geliang

>
> 'git diff' shows that the state at the head of the branch is identical to
> the export branch (rebased on net-next). I also checked out the last
> "net-next" commit and confirmed that mptcp_join.sh ran as expected.
>
>
> Compared to export/20220303T054913, I did the following:
>
>   * Rebased on net-next (which had the -net tree merged today). There was=
 a
> minor conflict in the bpf commits that made the "Update TopGit Tree"
> action fail when I manually started it today, which I resolved.
>
>   * Moved the userspace PM commits and the MP_FAIL / infinite fallback
> patches after all the net-next patches I expect to upstream in the next
> week. There were quite a few mptcp_join.sh conflicts to figure out.
>
>   * However, I left "selftests: mptcp: add invert check in check_transfer=
"
> earlier in the patch series to reduce conflicts with the mptcp_join.sh
> refactor patches.
>
>   * Added a "net-next-next" marker commit
>
>
> --
> Mat Martineau
> Intel
>
