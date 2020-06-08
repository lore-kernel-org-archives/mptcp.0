Content-Type: multipart/mixed; boundary="===============8198548285453809630=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [kbuild] [mptcp:export 5/10] net/mptcp/subflow.c:512
 subflow_syn_recv_sock() error: uninitialized symbol 'subflow_req'.
Date: Mon, 08 Jun 2020 16:34:37 +0300
Message-ID: <20200608133437.GR22511@kadam>
In-Reply-To: a77061c3f7ef8ef800e3646b6b2165774594564d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4611

--===============8198548285453809630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 03:29:12PM +0200, Paolo Abeni wrote:
> BTW I'll be curious to learn how this report has been created?!? Are
> you using a kbuild bot instance to run smack on mptcp export branch ?!?
> =


The kbuild bot run Smatch on whatever trees it can find.  Then I look it
over and forward to ignore the warnings.

regards,
dan carpenter

--===============8198548285453809630==--
