Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78852C80
	for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 15:55:50 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id p13so12459779edw.0
        for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IF//cHEfBMzNHGU/hjir9xXjwz0eGGhbIvfQ+K2fyYQ=;
        b=HBFZJFLt3xDM+kN8k1WNBRAwp4w1rTXQXTbCrglaWqMveS6RO1tREbAm6qrrgnDPXB
         FPkBpSjKZe6hZCPdIbvkCWRn65ih2CkKuud+1ubXKiJ0l4LKMd7uLLl7I4uU3gP9gLi8
         jD3zZZ19Jv0a1YHOhClVVoA0pm6GnZQsrba/V4fAQNy2ddXiBs+qIGpbneSnnHEVqvpI
         M4iAoKjjUuE+28FaPwn3hraJ5+nj5hquIMsjirUHXGFepVzgxH31wT04JEiBYDveEdZV
         hT/2fnaXLTEI+gYu4kMtn1u9jBgDokyiB+S4xvrsiDFfa0fUhHNjTBzNUQ+UduYrCWzH
         oE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IF//cHEfBMzNHGU/hjir9xXjwz0eGGhbIvfQ+K2fyYQ=;
        b=z9Coy3B+8SKoAt86cQWYcEbtb/Yvgd1tMujDbOwtCke9DfqLZ7xc8qLRN9LPzIOQVw
         uM8mQdrPMd75qsEypp/2OUAFlrWNuFNfY1tmy2zxaQfoI5E9F8+Z8HyhY5mlS7vNynMP
         gnrLZAhR2x+3Q6W/JOr+zErLxJx31jL+3HuiVNCAqSAGncMIe47mE2BWmLyterK67rzW
         UeJ3RXhmk8qptKAzBCvglpEZVfQ8MiSHvXL+IR8wHDar+fSu7KtYVrzKCfH4weInZbPi
         Fi9kFvKyb8IxjSMnklVTh+0SihwqOb4siKxiZ0rIxjo2e/G5jiK+3vcII5kNyM1rxUxl
         h0PQ==
X-Gm-Message-State: AOAM533F+czjqh0G5GdqKSjDnyJ405KZaRJ9r+clgyiX9Gjk3Hp9tmru
	YEJme4pkAg7DfIsmgF9MsxZeD5wFV1lYgDOEXbg3hSQc
X-Google-Smtp-Source: ABdhPJw4Wu+mXoRhvmsJsGb9fAzzOyJsUONfP2cLGM8Xruc5TBTwF31XonhljJvCAfRWpirn2NZEkfXYqRcmDkHreJg=
X-Received: by 2002:a05:6402:493:: with SMTP id k19mr236709edv.386.1634140548950;
 Wed, 13 Oct 2021 08:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACry=t6JVP+5AUUs7KggjMhQirQvyQsVhJiXgM38xK1v=6qh9w@mail.gmail.com>
 <CAAHOsNv41B45ahxYsC1Xq7Ri3Hryt5m8GscFd51fY=S1NT8ccA@mail.gmail.com> <CACry=t5i7Ks9UbpzBVAGG81x3GSqGfW6nm_HiFRgOsYkrHbBwA@mail.gmail.com>
In-Reply-To: <CACry=t5i7Ks9UbpzBVAGG81x3GSqGfW6nm_HiFRgOsYkrHbBwA@mail.gmail.com>
From: Paolo Abeni <paolo.abeni@gmail.com>
Date: Wed, 13 Oct 2021 17:55:38 +0200
Message-ID: <CAAHOsNttcY_+f4rhRRjz0gVEpJpzrKze12TY11yX4u=0CyDJTg@mail.gmail.com>
Subject: Re: MPTCP with Python issue
To: Robert Bowyer <robert.bowyer@flylogix.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 13, 2021 at 5:42 PM Robert Bowyer
<robert.bowyer@flylogix.com> wrote:
> Thank you for getting back to me so quickly.  Will revert to mailing list as you suggest.

It looks like the ML has been accidentally dropped from the recipients list ;)

> I think you are right about the server and I am wondering if the following should be added to the server stap
>
>  /* Override calls for TCP sockets to become MPTCP sockets */
> if ((SOCK_STREAM == (type & SOCK_TYPE_MASK)) && ((IPPROTO_TCP == protocol) || (0 == protocol)))
> protocol = IPPROTO_MPTCP;

Indeed that is required. Please note that the 'mptcpize' tool already
take care of it - sort of.

> So next step will be to get to latest version of kernel going and grab data you suggest, and then I'll post my findings into github tracker.

Thanks!

Paolo
